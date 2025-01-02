import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class FieldsApi {
  const FieldsApi();

  Future<Response> fetchRawData(String url) async {
    return await http.get(Uri.parse(url));
  }
}
