import 'package:flutter/material.dart';

class Cell {
  final int column, row;
  final bool isBlocked, isStart, isEnd;
  Color color;

  Cell(
      {required this.column,
      required this.row,
      required this.isBlocked,
      required this.isStart,
      required this.isEnd,
      required this.color});

  factory Cell.noColor(
      {required int column,
      required int row,
      required bool isBlocked,
      required bool isStart,
      required bool isEnd}) {
    if (isBlocked) {
      return Cell(
        column: column,
        row: row,
        isBlocked: isBlocked,
        isStart: isStart,
        isEnd: isEnd,
        color: const Color(0xFF000000),
      );
    }

    if (isStart) {
      return Cell(
        column: column,
        row: row,
        isBlocked: isBlocked,
        isStart: isStart,
        isEnd: isEnd,
        color: const Color(0xFF64FFDA),
      );
    }

    if (isEnd) {
      return Cell(
        column: column,
        row: row,
        isBlocked: isBlocked,
        isStart: isStart,
        isEnd: isEnd,
        color: const Color(0xFF009688),
      );
    }

    return Cell(
      column: column,
      row: row,
      isBlocked: isBlocked,
      isStart: isStart,
      isEnd: isEnd,
      color: const Color(0xFFFFFFFF),
    );
  }

  @override
  String toString() {
    return 'Cell(column: $column, row: $row, isBlocked: $isBlocked, isStart: $isStart, isEnd: $isEnd, color: $color)';
  }
}
