import 'dart:io';

import 'package:eaton_spark/src/bloc/map/bloc.dart';
import 'package:eaton_spark/src/models/map.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  static Set<Marker> _markers = {};

  static Set<Polyline> _polylines = {};

  static Set<Marker> get markers => _markers;

  static Set<Polyline> get polylines => _polylines;

  static BitmapDescriptor? stationIcon;

  static Future<void> getRoute({
    required LatLng source,
    required LatLng destination,
    TravelMode mode = TravelMode.driving,
    List<String> waypoints = const ["via:Nearest EV Stations"],
    String departureTime = 'now',
  }) async {
    GoogleMapBloc().changeMap(GoogleMapStatus.searching);

    Map<String, dynamic> json = {'data': 0};

    try {
      json['data'] = await MapsAPIService.makeJsonPost(
        route: MapRoutes.directions,
        body: {
          "source": [source.latitude, source.longitude],
          "destination": "Mumbai",
          "mode": TravelMode.driving.name,
          "departure_time": departureTime,
          "waypoints": [
            [destination.latitude, destination.longitude]
          ],
          // _markers
          //     .map((e) => [e.position.latitude, e.position.longitude])
          //     .toList(), // search keyword
          "optimize_waypoints": true,
        },
      );
    } on Exception catch (e) {
      print('Fetching Directions to selected station failed with error: $e');
    }

    final MapPolylines mapPolylines =
        MapPolylines.fromJson(json['data'][0]['overview_polyline']['points']);

    _markers.clear();
    _markers.addAll([
      Marker(
        markerId: MarkerId(source.toString()),
        position: source,
        icon: BitmapDescriptor.defaultMarker,
      ),
      Marker(
        markerId: MarkerId(destination.toString()),
        position: destination,
        icon: stationIcon!,
      ),
    ]);

    _polylines.clear();
    _polylines.add(
      mapPolylines.polyline,
    );

    GoogleMapService.currentLatLng().then((value) async {
      GoogleMapService.controller!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: value,
            zoom: 15,
          ),
        ),
      );
    });

    GoogleMapBloc().routingMode();
    return;
  }

  static Future<Position> _currentLocation() async {
    stationIcon ??= await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(
        size: Size(4, 4),
        devicePixelRatio: 0.1,
      ),
      'assets/images/small-icon-station.png',
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

  static Future<MapPlacesNearby> stationsNearby() async {
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
          // onTap: () async {
          //   await getRoute(
          //       source: currentPosition,
          //       destination: mapPlace.geometry.location.latlng);
          // },
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
    final double zoom = 11;
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
