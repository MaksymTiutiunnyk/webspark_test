import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:webspark_test/data/models/cell.dart';

void main() {
  group('Cell Class', () {
    test('should create a valid Cell instance with all properties', () {
      final cell = Cell(
        column: 1,
        row: 1,
        isBlocked: false,
        isStart: true,
        isEnd: false,
        color: const Color(0xFF64FFDA),
      );

      expect(cell.column, 1);
      expect(cell.row, 1);
      expect(cell.isBlocked, false);
      expect(cell.isStart, true);
      expect(cell.isEnd, false);
      expect(cell.color, const Color(0xFF64FFDA));
    });

    test('should return Cell with blocked color when isBlocked is true', () {
      final cell = Cell.noColor(
        column: 2,
        row: 2,
        isBlocked: true,
        isStart: false,
        isEnd: false,
      );

      expect(cell.color, const Color(0xFF000000));
    });

    test('should return Cell with start color when isStart is true', () {
      final cell = Cell.noColor(
        column: 3,
        row: 3,
        isBlocked: false,
        isStart: true,
        isEnd: false,
      );

      expect(cell.color, const Color(0xFF64FFDA));
    });

    test('should return Cell with end color when isEnd is true', () {
      final cell = Cell.noColor(
        column: 4,
        row: 4,
        isBlocked: false,
        isStart: false,
        isEnd: true,
      );

      expect(cell.color, const Color(0xFF009688));
    });

    test(
        'should return Cell with default color when isBlocked, isStart, and isEnd are false',
        () {
      final cell = Cell.noColor(
        column: 5,
        row: 5,
        isBlocked: false,
        isStart: false,
        isEnd: false,
      );

      expect(cell.color, const Color(0xFFFFFFFF));
    });

    test('should return the correct string representation of the Cell', () {
      final cell = Cell(
        column: 6,
        row: 6,
        isBlocked: false,
        isStart: true,
        isEnd: false,
        color: const Color(0xFF64FFDA),
      );

      expect(
        cell.toString(),
        'Cell(column: 6, row: 6, isBlocked: false, isStart: true, isEnd: false, color: Color(0xff64ffda))',
      );
    });
  });
}
