import 'dart:convert';

import 'package:http/http.dart' as http;

enum MapRoutes { places_nearby, autocomplete, autocomplete_query, directions }

enum TravelMode { driving, walking, bicycling, transit }

class MapsAPIService {
  static const String _BASE_URL = 'http://192.168.29.162:6000/';
  MapsAPIService._internal();
  static final MapsAPIService _instance = MapsAPIService._internal();
  factory MapsAPIService() => _instance;

  static Future<dynamic> makeJsonPost(
      {required MapRoutes route, required Map<String, dynamic> body}) async {
    http.Response response = await http.post(Uri.parse(_BASE_URL + route.name),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body));

    return jsonDecode(response.body);
  }
}
