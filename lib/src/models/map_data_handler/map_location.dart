part of 'map_data_handler.dart';

class MapLocation {
  MapLocation({
    required this.latlng,
  });

  get lat => latlng.latitude;
  get lng => latlng.longitude;

  final LatLng latlng;
  MapLocation.fromJson(Map<String, dynamic> json)
      : latlng = LatLng(json['lat'], json['lng']);

  Map<String, dynamic> toJson() => {
        'latlng': latlng.toJson(),
      };
}
