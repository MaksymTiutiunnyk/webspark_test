import 'package:flutter/material.dart';
import 'package:webspark_test/data/models/cell.dart';
import 'package:webspark_test/data/models/field.dart';

class FieldGrid extends StatelessWidget {
  final Field field;
  final List<Cell> result;
  const FieldGrid({super.key, required this.field, required this.result});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.loose,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: field.columns,
        ),
        itemCount: field.cells.length,
        itemBuilder: (context, index) {
          final cell = field.cells[index];
          if (result.contains(cell) && !cell.isStart && !cell.isEnd) {
            cell.color = const Color(0xFF4CAF50);
          }

          return Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(color: cell.color, border: Border.all()),
            child: Text(
              '(${cell.row},${cell.column})',
              style: TextStyle(
                  color: cell.isBlocked ? Colors.white : Colors.black),
            ),
          );
        },
      ),
    );
  }
}
