import 'dart:convert';
import 'package:webspark_test/data/models/field.dart';
import 'package:webspark_test/data/models/cell.dart';
import 'package:webspark_test/data/data_providers/fields_api.dart';

class FieldsRepository {
  final FieldsApi fieldsApi;

  FieldsRepository(this.fieldsApi);

  Future<List<Field>> fetchData(String url) async {
    final response = await fieldsApi.fetchRawData(url);

    if (response.statusCode != 200) {
      throw Exception('Ooops, error ${response.statusCode}');
    }

    final Map<String, dynamic> mapResponse = jsonDecode(response.body);

    final List<dynamic> fieldsData = mapResponse['data'];

    List<Field> fields = fieldsData.map((fieldData) {
      final List<String> cellsData = List<String>.from(fieldData['field']);
      final Map<String, dynamic> startCellData = fieldData['start'];
      final Map<String, dynamic> endCellData = fieldData['end'];

      List<Cell> cells = [];
      for (int row = 0; row < cellsData.length; ++row) {
        for (int column = 0; column < cellsData[row].length; ++column) {
          bool isBlocked = cellsData[row][column] == 'X';
          bool isStart = row == startCellData['y'] && column == startCellData['x'];
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

      return Field(cells: cells, start: startCell, end: endCell);
    }).toList();

    return fields;
  }
}
