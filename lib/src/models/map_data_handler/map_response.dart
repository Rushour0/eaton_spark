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

class MapPolylines extends MapResponse {
  const MapPolylines({
    required this.polyline,
  });

  final Polyline polyline;

  @override
  MapPolylines.fromJson(String polylineEncoded)
      : polyline = Polyline(
          polylineId: PolylineId(polylineEncoded),
          points: PolylineDo.Polyline.Decode(
                  encodedString: polylineEncoded, precision: 5)
              .decodedCoords
              .map((e) => LatLng(e[0], e[1]))
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
