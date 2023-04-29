import 'dart:convert';

import 'package:http/http.dart' as http;

class MapsAPI {
  static const String _BASE_URL = 'https://eaton-spark.loca.lt';
  MapsAPI._internal();
  static final MapsAPI _instance = MapsAPI._internal();
  factory MapsAPI() => _instance;

  static Future<Map<String, dynamic>?> makeJsonPost(
      {required Map<String, dynamic> body}) async {
    http.Response response = await http.post(
      Uri.parse(_BASE_URL),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: body,
    );

    return jsonDecode(response.body) as Map<String, dynamic>;
  }
}
