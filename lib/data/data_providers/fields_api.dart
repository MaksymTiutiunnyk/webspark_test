import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class FieldsApi {
  const FieldsApi();

  Future<Response> fetchRawData(String url) async {
    return await http.get(Uri.parse(url));
  }

  Future<Response> sendResults({
    required List<Map<String, dynamic>> body,
    required String url,
  }) async {
    return await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: json.encode(body),
    );
  }
}
