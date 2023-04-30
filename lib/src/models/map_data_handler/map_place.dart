part of 'map_data_handler.dart';

class MapStation {
  const MapStation({
    required this.name,
    required this.icon,
    required this.vicinity,
    required this.geometry,
    this.costPerKwh = 6.85,
    this.fastChargeCostPerKwh = 8.21,
  });

  final String name;
  final String vicinity;
  final String icon;
  final MapGeometry geometry;
  final double costPerKwh;
  final double fastChargeCostPerKwh;

  Map<String, dynamic> toJson() => {
        "name": name,
        "icon": icon,
        "vicinity": vicinity,
        "geometry": geometry.toJson(),
      };

  factory MapStation.fromJson(Map<String, dynamic> json) => MapStation(
        name: json["name"],
        icon: json["icon"],
        vicinity: json["vicinity"],
        geometry: MapGeometry.fromJson(json["geometry"]),
      );
}
