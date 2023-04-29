class MapPlacesNearby extends MapResponse {
  List<dynamic>? htmlAttributions;
  String? nextPageToken;
  List<Map<String, dynamic>>? results;

  @override
  MapPlacesNearby.fromJson(Map<String, dynamic> json) {
    this.htmlAttributions = json["html_attributions"];
    this.nextPageToken = json["next_page_token"];
    this.results = List<Map<String, dynamic>>.from(json["results"]);
  }

  @override
  Map<String, dynamic> toJson() => {
        "html_attributions": htmlAttributions,
        "next_page_token": nextPageToken,
        "results": results!.map((e) => Map<String, dynamic>.from(e)).toList(),
      };
}

abstract class MapResponse {
  MapResponse();

  MapResponse.fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson();
}
