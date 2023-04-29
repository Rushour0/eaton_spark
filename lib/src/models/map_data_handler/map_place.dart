part of 'map_data_handler.dart';

class MapPlace {
  const MapPlace({
    required this.name,
    required this.icon,
    required this.address,
    required this.geometry,
  });

  final String name;
  final String address;
  final Uri icon;
  final MapGeometry geometry;

  Map<String, dynamic> toJson() => {
        "name": name,
        "icon": icon.toString(),
        "address": address,
        "geometry": geometry.toJson(),
      };

  factory MapPlace.fromJson(Map<String, dynamic> json) => MapPlace(
        name: json["name"],
        icon: Uri.parse(json["icon"]),
        address: json["address"],
        geometry: MapGeometry.fromJson(json["geometry"]),
      );
}
