part of 'map_data_handler.dart';

class MapLocation {
  MapLocation({
    required this.latlng,
  });

  double get lat => latlng.latitude;
  double get lng => latlng.longitude;

  final LatLng latlng;
  MapLocation.fromJson(Map<String, dynamic> json)
      : latlng = LatLng(json['lat'], json['lng']);

  Map<String, dynamic> toJson() => {
        'latlng': latlng.toJson(),
      };
}
