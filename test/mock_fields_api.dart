import 'package:http/http.dart';
import 'package:webspark_test/data/data_providers/fields_api.dart';

class MockFieldsApi implements FieldsApi {
  @override
  Future<Response> fetchRawData(String url) async {
    if (url == 'valid_url') {
      return Response(
        '{"data": [{"id": "1", "field": ["...", "...", "..."], "start": {"x": 0, "y": 0}, "end": {"x": 1, "y": 1}}]}',
        200,
      );
    } else {
      throw Exception('Invalid URL');
    }
  }

  @override
  Future<Response> sendResults({
    required List<Map<String, dynamic>> body,
    required String url,
  }) async {
    if (url == 'valid_url' && body.isNotEmpty) {
      return Response('{"success": true}', 200);
    } else {
      throw Exception('Unexpected error');
    }
  }
}
