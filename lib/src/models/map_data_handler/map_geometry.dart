part of 'map_data_handler.dart';

class MapGeometry {
  MapGeometry({
    required this.location,
    required this.viewport,
  });

  final MapLocation location;
  final MapViewport viewport;

  Map<String, dynamic> toJson() => {
        "location": location.toJson(),
        "viewport": viewport.toJson(),
      };

  factory MapGeometry.fromJson(Map<String, dynamic> json) => MapGeometry(
        location: MapLocation.fromJson(json["location"]),
        viewport: MapViewport.fromJson(json["viewport"]),
      );
}
