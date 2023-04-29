import 'dart:convert';

import 'package:http/http.dart' as http;

enum MapRoutes { places_nearby, autocomplete, autocomplete_query }

class MapsAPI {
  static const String _BASE_URL = 'https://eaton-spark.loca.lt/';
  MapsAPI._internal();
  static final MapsAPI _instance = MapsAPI._internal();
  factory MapsAPI() => _instance;

  static Future<Map<String, dynamic>?> makeJsonPost(
      {required MapRoutes route, required Map<String, dynamic> body}) async {
    http.Response response = await http.post(
      Uri.parse(_BASE_URL + route.name),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );

    return jsonDecode(response.body) as Map<String, dynamic>;
  }
}
