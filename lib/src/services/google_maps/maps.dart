
import 'package:eaton_spark/src/bloc/map/bloc.dart';
import 'package:eaton_spark/src/models/map.dart';
import 'package:eaton_spark/src/models/service_tab.dart';
import 'package:flutter/material.dart';

import 'package:geolocator_android/geolocator_android.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:eaton_spark/src/models/map_data_handler/map_data_handler.dart';
import 'package:eaton_spark/src/services/google_maps/api.dart';

class GoogleMapService {
  GoogleMapService._internal();

  static final GoogleMapService _instance = GoogleMapService._internal();

  factory GoogleMapService() => _instance;

  static final GeolocatorAndroid _geolocatorAndroid = GeolocatorAndroid();

  static GoogleMapController? controller;

  static final Set<Marker> _markers = {};

  static final Set<Polyline> _polylines = {};

  static Set<Marker> get markers => _markers;

  static Set<Polyline> get polylines => _polylines;

  static BitmapDescriptor? stationIcon, batteryIcon;

  static mode(
    ServicesTabMode mode, {
    dynamic source,
    dynamic destination,
    dynamic batteryLocation,
    dynamic batteryDate,
    dynamic batteryTime,
    dynamic planLocation,
    dynamic planDate,
    dynamic planTime,
  }) {
    switch (mode) {
      case ServicesTabMode.charge_now:
        _markers.clear();
        _polylines.clear();
        _stationsNearby();
        break;
      case ServicesTabMode.intercity:
        _markers.clear();
        _polylines.clear();
        _getRoute(source: source, destination: destination, midpoint: true);
        break;
      case ServicesTabMode.battery_swap:
        _markers.clear();
        _polylines.clear();
        _batteryViaLocation(
          location: batteryLocation,
        );
        break;
      case ServicesTabMode.plan_charge:
        _markers.clear();
        _polylines.clear();
        break;
      case ServicesTabMode.map:
        break;
    }
  }

  static void clearRoutes() {
    _polylines.clear();
  }

  static Future<void> _batteryViaLocation({
    dynamic location,
  }) async {
    _markers.clear();

    GoogleMapBloc().changeMap(GoogleMapStatus.searching);
    Map<String, dynamic> json = {};
    final LatLng currentPosition = await currentLatLng();
    try {
      json = await MapsAPIService.makeJsonPost(
        route: MapRoutes.places_nearby,
        body: {
          "location": currentPosition,
          "radius": 10000, // in meters
          "keyword": "EV Battery", // search keyword
        },
      );
    } on Exception catch (e) {
      print('Fetching Nearby Stations failed with error: $e');
    }
    final MapPlacesNearby placesNearby = MapPlacesNearby.fromJson(json);

    for (MapStation mapPlace in placesNearby.results!) {
      _markers.add(
        Marker(
          markerId: MarkerId(mapPlace.vicinity),
          position: mapPlace.geometry.location.latlng,
          icon: batteryIcon!,
          onTap: () async {
            await _getRoute(
                source: currentPosition,
                destination: mapPlace.geometry.location.latlng);
          },
          infoWindow: InfoWindow(
            title: mapPlace.name,
            snippet: mapPlace.vicinity,
          ),
        ),
      );
    }
    _calculateZoom(
      main: placesNearby.results!.first.geometry.location.latlng,
      faraway: placesNearby.results!.last.geometry.location.latlng,
    );

    GoogleMapBloc().addedMarkers();

    return;
  }

  static Future<void> _getRoute({
    required dynamic source,
    required dynamic destination,
    bool midpoint = false,
    TravelMode mode = TravelMode.driving,
    String departureTime = 'now',
  }) async {
    GoogleMapBloc().changeMap(GoogleMapStatus.searching);

    Map<String, dynamic> json = {'data': 0};
    if (source == "current") {
      source = await GoogleMapService.currentLatLng();
    }
    try {
      json['data'] = await MapsAPIService.makeJsonPost(
        route: MapRoutes.directions,
        body: {
          "source": source.runtimeType == String
              ? source
              : [source.latitude, source.longitude],
          "destination": destination.runtimeType == String
              ? destination
              : [destination.latitude, destination.longitude],
          "mode": mode.name,
          "departure_time": departureTime,
          "waypoints": [],
          "optimize_waypoints": true,
        },
      );
    } on Exception catch (e) {
      print('Fetching Directions to selected station failed with error: $e');
    }

    final MapDirections mapDirections = MapDirections.fromJson(json['data'][0]);

    _polylines.clear();
    _polylines.add(
      mapDirections.polyline,
    );
    _markers.clear();
    // Temporary - Add mid point marker
    if (midpoint) {
      int mid = (mapDirections.polyline.points.length / 2).ceil();
      LatLng midPoint = mapDirections.polyline.points[mid];
      _markers.add(
        Marker(
          markerId: const MarkerId('midpoint'),
          position: midPoint,
          icon: BitmapDescriptor.defaultMarker,
        ),
      );
    }
    _markers.addAll([
      Marker(
        markerId: MarkerId(source.toString()),
        position: mapDirections.start,
        icon: BitmapDescriptor.defaultMarker,
      ),
      Marker(
        markerId: MarkerId(destination.toString()),
        position: mapDirections.end,
        icon: BitmapDescriptor.defaultMarker,
      ),

      // Temporary - Add mid point marker
    ]);
    GoogleMapService.controller!.animateCamera(
      CameraUpdate.newLatLngBounds(
        mapDirections.bounds,
        50,
      ),
    );
    GoogleMapBloc().activateRoutingMode();
  }

  static Future<Position> _currentLocation() async {
    stationIcon ??= await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(
        size: Size(4, 4),
        devicePixelRatio: 0.1,
      ),
      'assets/images/small-icon-station.png',
      mipmaps: false,
    );
    batteryIcon ??= await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(
        size: Size(4, 4),
        devicePixelRatio: 0.1,
      ),
      'assets/images/small-icon-battery.png',
      mipmaps: false,
    );
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await _geolocatorAndroid.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await _geolocatorAndroid.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _geolocatorAndroid.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await _geolocatorAndroid.getCurrentPosition();
  }

  static Future<MapPlacesNearby> _stationsNearby() async {
    GoogleMapBloc().changeMap(GoogleMapStatus.searching);
    _markers.clear();
    Map<String, dynamic> json = {};
    final LatLng currentPosition = await currentLatLng();
    try {
      json = await MapsAPIService.makeJsonPost(
        route: MapRoutes.places_nearby,
        body: {
          "location": [currentPosition.latitude, currentPosition.longitude],
          "radius": 10000, // in meters
          "keyword": "EV Stations", // search keyword
        },
      );
    } on Exception catch (e) {
      print('Fetching Nearby Stations failed with error: $e');
    }
    final MapPlacesNearby placesNearby = MapPlacesNearby.fromJson(json);

    for (MapStation mapPlace in placesNearby.results!) {
      _markers.add(
        Marker(
          markerId: MarkerId(mapPlace.vicinity),
          position: mapPlace.geometry.location.latlng,
          icon: stationIcon!,
          onTap: () async {
            await _getRoute(
                source: currentPosition,
                destination: mapPlace.geometry.location.latlng);
          },
          infoWindow: InfoWindow(
            title: mapPlace.name,
            snippet: mapPlace.vicinity,
          ),
        ),
      );
    }
    _calculateZoom(
      main: currentPosition,
      faraway: placesNearby.results!.last.geometry.location.latlng,
    );

    GoogleMapBloc().addedMarkers();

    return placesNearby;
  }

  static Future<LatLng> currentLatLng() async {
    final Position position = await _currentLocation();
    return LatLng(position.latitude, position.longitude);
  }

  static void _calculateZoom({required LatLng main, required LatLng faraway}) {
    const double zoom = 11;
    controller!.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: main,
          zoom: zoom,
        ),
      ),
    );
  }
}
