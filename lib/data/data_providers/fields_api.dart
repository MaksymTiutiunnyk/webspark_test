import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:webspark_test/main.dart';

class FieldsApi {
  const FieldsApi();

  Future<Response> fetchRawData(String url) async {
    return await http.get(Uri.parse(url));
  }

  Future<Response> sendResults(List<Map<String, dynamic>> body) async {
    return await http.post(
      Uri.parse(kBaseUrl),
      headers: {"Content-Type": "application/json"},
      body: json.encode(body),
    );
  }
}
