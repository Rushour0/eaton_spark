import 'package:geolocator_android/geolocator_android.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:eaton_spark/src/models/map_data_handler/map_data_handler.dart';
import 'package:eaton_spark/src/services/google_maps/api.dart';

class GoogleMapService {
  static final GeolocatorAndroid _geolocatorAndroid = GeolocatorAndroid();

  static GoogleMapController? controller;

  static Future<Position> _currentLocation() async {
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
    LatLng currentPosition = await currentLatLng();
    List<LatLng> stations = [];
    Map<String, dynamic>? json = await MapsAPIService.makeJsonPost(
        route: MapRoutes.places_nearby,
        body: {
          "location": [currentPosition.latitude, currentPosition.longitude],
          "radius": 10000, // in meters
          "keyword": "EV Stations", // search keyword
        });
    MapPlacesNearby placesNearby = MapPlacesNearby.fromJson(json!);
    placesNearby.results?.forEach((element) {
      stations.add(
          LatLng(element.geometry.location.lat, element.geometry.location.lng));
    });
    return placesNearby;
  }

  static Future<LatLng> currentLatLng() async {
    final Position position = await _currentLocation();
    return LatLng(position.latitude, position.longitude);
  }
}
