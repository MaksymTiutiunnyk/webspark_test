import 'dart:math';

import 'package:webspark_test/data/models/cell.dart';

class Field {
  final String id;
  final List<Cell> cells;
  final Cell start, end;
  final int rows, columns;

  Field(
      {required this.id,
      required this.cells,
      required this.start,
      required this.end})
      : rows = sqrt(cells.length).toInt(),
        columns = sqrt(cells.length).toInt();

  @override
  String toString() {
    return 'Field(id: $id, cells: ${cells.length} cells, start: $start, end: $end)';
  }
}
