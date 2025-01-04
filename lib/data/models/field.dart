import 'package:webspark_test/data/models/cell.dart';

class Field {
  final String id;
  final List<Cell> cells;
  final Cell start, end;
  final int rows, columns;

  Field({
    required this.id,
    required this.cells,
    required this.start,
    required this.end,
    required this.rows,
    required this.columns,
  }) {
    if (rows != columns || rows * columns != cells.length) {
      throw Exception('Field must be square');
    }
  }

  @override
  String toString() {
    return 'Field(id: $id, cells: ${cells.length} cells, start: $start, end: $end)';
  }
}
