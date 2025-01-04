import 'package:flutter_test/flutter_test.dart';
import 'package:webspark_test/data/models/cell.dart';
import 'package:webspark_test/data/models/field.dart';

void main() {
  group('Field Class', () {
    test('should create a valid Field instance', () {
      final cells = [
        Cell.noColor(
            column: 0, row: 0, isBlocked: false, isStart: true, isEnd: false),
        Cell.noColor(
            column: 1, row: 0, isBlocked: false, isStart: false, isEnd: true),
        Cell.noColor(
            column: 0, row: 1, isBlocked: false, isStart: false, isEnd: false),
        Cell.noColor(
            column: 1, row: 1, isBlocked: false, isStart: false, isEnd: false),
      ];
      final startCell = cells[0];
      final endCell = cells[1];

      final field = Field(
        id: '1',
        cells: cells,
        start: startCell,
        end: endCell,
        rows: 2,
        columns: 2,
      );

      expect(field.id, '1');
      expect(field.cells.length, 4);
      expect(field.rows, 2);
      expect(field.columns, 2);
      expect(field.start, startCell);
      expect(field.end, endCell);
    });

    test('should throw an error if the field is not square', () {
      final cells = [
        Cell.noColor(
          column: 0,
          row: 0,
          isBlocked: false,
          isStart: true,
          isEnd: false,
        ),
        Cell.noColor(
          column: 1,
          row: 0,
          isBlocked: false,
          isStart: false,
          isEnd: true,
        ),
      ];
      final startCell = cells[0];
      final endCell = cells[1];

      expect(
        () => Field(
          id: '1',
          cells: cells,
          start: startCell,
          end: endCell,
          rows: 0,
          columns: 1,
        ),
        throwsA(isA<Exception>()),
      );
    });

    test('should return the correct string representation of the field', () {
      final cells = [
        Cell.noColor(
            column: 0, row: 0, isBlocked: false, isStart: true, isEnd: false),
        Cell.noColor(
            column: 1, row: 0, isBlocked: false, isStart: false, isEnd: true),
        Cell.noColor(
            column: 0, row: 1, isBlocked: false, isStart: false, isEnd: false),
        Cell.noColor(
            column: 1, row: 1, isBlocked: false, isStart: false, isEnd: false),
      ];
      final startCell = cells[0];
      final endCell = cells[1];

      final field = Field(
        id: '1',
        cells: cells,
        start: startCell,
        end: endCell,
        rows: 2,
        columns: 2,
      );

      expect(
        field.toString(),
        'Field(id: 1, cells: 4 cells, start: Cell(column: 0, row: 0, isBlocked: false, isStart: true, isEnd: false, color: Color(0xff64ffda)), end: Cell(column: 1, row: 0, isBlocked: false, isStart: false, isEnd: true, color: Color(0xff009688)))',
      );
    });
  });
}
