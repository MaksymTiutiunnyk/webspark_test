import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webspark_test/data/models/cell.dart';
import 'package:webspark_test/data/models/field.dart';
import 'package:webspark_test/logic/cubit/percentage_cubit.dart';

class ShortestPathFinder {
  final Field field;
  final BuildContext context;

  ShortestPathFinder(this.field, this.context);

  List<Map<String, int>> findShortestPath() {
    final start = field.start;
    final end = field.end;

    Map<Cell, double> gScores = {start: 0};
    Map<Cell, double> fScores = {start: _heuristic(start, end)};
    Map<Cell, Cell?> cameFrom = {};

    List<Cell> openQueue = [start];
    Set<Cell> closedQueue = {};

    int processedCells = 0;

    while (openQueue.isNotEmpty) {
      openQueue.sort((a, b) => (fScores[a] ?? double.infinity)
          .compareTo(fScores[b] ?? double.infinity));
      final current = openQueue.removeAt(0);

      if (current == end) {
        context
            .read<PercentageCubit>()
            .updateProcessedCells(field.cells.length - processedCells);
        return _reconstructPath(cameFrom, current);
      }

      closedQueue.add(current);
      ++processedCells;
      context.read<PercentageCubit>().updateProcessedCells(1);

      for (final neighbor in _getNeighbors(current)) {
        if (neighbor.isBlocked || closedQueue.contains(neighbor)) continue;

        final newGScore = (gScores[current] ?? double.infinity) +
            _heuristic(current, neighbor);

        if (!openQueue.contains(neighbor)) {
          openQueue.add(neighbor);
        } else if (newGScore >= (gScores[neighbor] ?? double.infinity)) {
          continue;
        }

        cameFrom[neighbor] = current;
        gScores[neighbor] = newGScore;
        fScores[neighbor] = newGScore + _heuristic(neighbor, end);
      }
    }

    return [];
  }

  double _heuristic(Cell a, Cell b) {
    return sqrt(pow((a.column - b.column), 2) + pow((a.row - b.row), 2));
  }

  List<Cell> _getNeighbors(Cell current) {
    final neighbors = <Cell>[];

    final directions = [
      [-1, 0],
      [1, 0],
      [0, -1],
      [0, 1],
      [-1, -1],
      [-1, 1],
      [1, -1],
      [1, 1],
    ];

    for (final direction in directions) {
      final newCol = current.column + direction[0];
      final newRow = current.row + direction[1];

      if (newRow >= 0 &&
          newRow < field.rows &&
          newCol >= 0 &&
          newCol < field.columns) {
        neighbors.add(field.cells
            .firstWhere((cell) => cell.row == newRow && cell.column == newCol));
      }
    }

    return neighbors;
  }

  List<Map<String, int>> _reconstructPath(
      Map<Cell, Cell?> cameFrom, Cell current) {
    List<Cell> path = [current];
    while (cameFrom[current] != null) {
      current = cameFrom[current]!;
      path.insert(0, current);
    }
    return path.map((cell) => {'x': cell.column, 'y': cell.row}).toList();
  }
}
