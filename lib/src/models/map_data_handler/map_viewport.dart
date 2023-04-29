part of 'map_data_handler.dart';

class MapViewport {
  MapViewport({
    required this.northeast,
    required this.southwest,
  });
  final LatLng northeast, southwest;

  Map<String, dynamic> toJson() => {
        "northeast": northeast.toJson(),
        "southwest": southwest.toJson(),
      };

  factory MapViewport.fromJson(Map<String, dynamic> json) => MapViewport(
        northeast: LatLng(json["northeast"]["lat"], json["northeast"]["lng"]),
        southwest: LatLng(json["southwest"]["lat"], json["southwest"]["lng"]),
      );
}
