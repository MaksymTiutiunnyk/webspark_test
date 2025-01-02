import 'package:webspark_test/data/models/cell.dart';

class Field {
  final List<Cell> cells;
  final Cell start, end;

  const Field({required this.cells, required this.start, required this.end});

  @override
  String toString() {
    return 'Field(cells: ${cells.length} cells, start: $start, end: $end)';
  }
}
