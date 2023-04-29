part of 'map_data_handler.dart';

class MapPlace {
  const MapPlace({
    required this.name,
    required this.icon,
    required this.vicinity,
    required this.geometry,
  });

  final String name;
  final String vicinity;
  final String icon;
  final MapGeometry geometry;

  Map<String, dynamic> toJson() => {
        "name": name,
        "icon": icon,
        "vicinity": vicinity,
        "geometry": geometry.toJson(),
      };

  factory MapPlace.fromJson(Map<String, dynamic> json) => MapPlace(
        name: json["name"],
        icon: json["icon"],
        vicinity: json["vicinity"],
        geometry: MapGeometry.fromJson(json["geometry"]),
      );
}
