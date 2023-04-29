part of 'map_data_handler.dart';

class MapPlacesNearby extends MapResponse {
  const MapPlacesNearby({
    this.htmlAttributions,
    this.nextPageToken,
    this.results,
  });

  final List<dynamic>? htmlAttributions;
  final String? nextPageToken;
  final List<MapPlace>? results;

  @override
  MapPlacesNearby.fromJson(Map<String, dynamic> json)
      : htmlAttributions = json["html_attributions"],
        nextPageToken = json["next_page_token"],
        results = List<MapPlace>.from(
          json["results"].map((mapPlace) {
            return MapPlace.fromJson(mapPlace);
          }).toList(),
        );

  @override
  Map<String, dynamic> toJson() => {
        "html_attributions": htmlAttributions,
        "next_page_token": nextPageToken,
        "results": results!.map((mapPlace) => mapPlace.toJson()).toList(),
      };
}

abstract class MapResponse {
  const MapResponse();
  MapResponse.fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson();
}
