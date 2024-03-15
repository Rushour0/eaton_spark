part of 'map_data_handler.dart';

class MapPlacesNearby extends MapResponse {
  const MapPlacesNearby({
    this.htmlAttributions,
    this.nextPageToken,
    this.results,
  });

  final List<dynamic>? htmlAttributions;
  final String? nextPageToken;
  final List<MapStation>? results;

  @override
  MapPlacesNearby.fromJson(Map<String, dynamic> json)
      : htmlAttributions = json["html_attributions"],
        nextPageToken = json["next_page_token"],
        results = List<MapStation>.from(
          json["results"].map((mapPlace) {
            return MapStation.fromJson(mapPlace);
          }).toList(),
        );

  @override
  Map<String, dynamic> toJson() => {
        "html_attributions": htmlAttributions,
        "next_page_token": nextPageToken,
        "results": results!.map((mapPlace) => mapPlace.toJson()).toList(),
      };
}

class MapDirections extends MapResponse {
  const MapDirections({
    required this.start,
    required this.end,
    required this.distance,
    required this.duration,
    required this.bounds,
    required this.polyline,
  });

  final Polyline polyline;
  final int distance; // in meters
  final int duration; // in seconds
  final LatLng start, end;
  final LatLngBounds bounds;

  @override
  MapDirections.fromJson(Map<String, dynamic> directions)
      : start = LatLng(
          directions['legs'][0]['start_location']['lat'],
          directions['legs'][0]['start_location']['lng'],
        ),
        end = LatLng(
          directions['legs'][0]['end_location']['lat'],
          directions['legs'][0]['end_location']['lng'],
        ),
        distance = directions['legs'][0]['distance']['value'],
        duration = directions['legs'][0]['duration']['value'],
        bounds = LatLngBounds(
          southwest: LatLng(
            directions['bounds']['southwest']['lat'],
            directions['bounds']['southwest']['lng'],
          ),
          northeast: LatLng(
            directions['bounds']['northeast']['lat'],
            directions['bounds']['northeast']['lng'],
          ),
        ),
        polyline = Polyline(
          polylineId: PolylineId(directions['overview_polyline']['points']),
          points: polylinePoints
              .decodePolyline(
                directions['overview_polyline']['points'],
              )
              .map(
                (e) => LatLng(e.latitude, e.longitude),
              )
              .toList(),
          color: Colors.blue,
          width: 2,
        );

  @override
  Map<String, dynamic> toJson() => {
        "polyline": polyline.toJson(),
      };
}

abstract class MapResponse {
  const MapResponse();
  MapResponse.fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson();
}
