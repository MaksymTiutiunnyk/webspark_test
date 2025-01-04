import 'dart:convert';
import 'package:http/http.dart';
import 'package:webspark_test/data/models/field.dart';
import 'package:webspark_test/data/models/cell.dart';
import 'package:webspark_test/data/data_providers/fields_api.dart';

class FieldsRepository {
  final FieldsApi fieldsApi;

  FieldsRepository(this.fieldsApi);

  Future<List<Field>> fetchData(String url) async {
    try {
      final response = await fieldsApi.fetchRawData(url);

      if (response.statusCode != 200) {
        throw Exception('Ooops, error ${response.statusCode}');
      }

      final Map<String, dynamic> mapResponse = jsonDecode(response.body);

      final List<dynamic> fieldsData = mapResponse['data'];

      return fieldsData.map((fieldData) {
        final List<String> cellsData = List<String>.from(fieldData['field']);
        final Map<String, dynamic> startCellData = fieldData['start'];
        final Map<String, dynamic> endCellData = fieldData['end'];

        List<Cell> cells = [];
        for (int row = 0; row < cellsData.length; ++row) {
          for (int column = 0; column < cellsData[row].length; ++column) {
            bool isBlocked = cellsData[row][column] == 'X';
            bool isStart =
                row == startCellData['y'] && column == startCellData['x'];
            bool isEnd = row == endCellData['y'] && column == endCellData['x'];

            cells.add(
              Cell.noColor(
                column: column,
                row: row,
                isBlocked: isBlocked,
                isStart: isStart,
                isEnd: isEnd,
              ),
            );
          }
        }

        final startCell = cells.firstWhere((cell) => cell.isStart);
        final endCell = cells.firstWhere((cell) => cell.isEnd);

        return Field(
          id: fieldData['id'],
          cells: cells,
          start: startCell,
          end: endCell,
          rows: cellsData.length,
          columns: cellsData[0].length,
        );
      }).toList();
    } catch (e) {
      if (e is FormatException) {
        throw Exception('Invalid response format');
      }
      if (e is ArgumentError) {
        throw Exception('Invalid URL');
      }
      if (e is ClientException) {
        throw Exception('Check your Internet connection, please');
      }
      rethrow;
    }
  }

  Future<void> sendResults({
    required List<Field> fields,
    required List<List<Cell>> results,
    required String url,
  }) async {
    try {
      List<Map<String, dynamic>> body = fields.map((field) {
        return {
          "id": field.id,
          "result": {
            "steps": results[fields.indexOf(field)].map((cell) {
              return {"x": cell.column.toString(), "y": cell.row.toString()};
            }).toList(),
            "path": results[fields.indexOf(field)]
                .map((cell) => "(${cell.column},${cell.row})")
                .join("->"),
          }
        };
      }).toList();

      final response = await fieldsApi.sendResults(body: body, url: url);
      if (response.statusCode != 200) {
        throw Exception('Ooops, error ${response.statusCode}');
      }
    } catch (e) {
      if (e is ClientException) {
        throw Exception('Check your Internet connection, please');
      }
      rethrow;
    }
  }
}
