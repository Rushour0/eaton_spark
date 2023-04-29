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

  static Set<Marker> get markers => _markers;

  static BitmapDescriptor? stationIcon;

  static Future<Position> _currentLocation() async {
    stationIcon = await BitmapDescriptor.fromAssetImage(
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

    for (MapPlace mapPlace in placesNearby.results!) {
      _markers.add(
        Marker(
          markerId: MarkerId(mapPlace.vicinity),
          position: mapPlace.geometry.location.latlng,
          icon: stationIcon!,
          infoWindow: InfoWindow(
            title: mapPlace.name,
            snippet: mapPlace.vicinity,
          ),
        ),
      );
    }
    GoogleMapBloc().changeMap(GoogleMapStatus.loaded);
    GoogleMapBloc().addedMarkers();

    return placesNearby;
  }

  static Future<LatLng> currentLatLng() async {
    final Position position = await _currentLocation();
    return LatLng(position.latitude, position.longitude);
  }
}
