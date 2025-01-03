import 'package:flutter/material.dart';
import 'package:webspark_test/data/models/cell.dart';
import 'package:webspark_test/data/models/field.dart';

class LargeFieldGrid extends StatelessWidget {
  final Field field;
  final List<Cell> result;
  const LargeFieldGrid({super.key, required this.field, required this.result});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.loose,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columnSpacing: 0,
          horizontalMargin: 0,
          headingRowHeight: 0,
          border: TableBorder.all(width: 1.5),
          columns: List.generate(
            field.columns,
            (_) => const DataColumn(label: SizedBox.shrink()),
          ),
          rows: List.generate(
            field.rows,
            (rowIndex) {
              return DataRow(
                cells: List.generate(
                  field.columns,
                  (columnIndex) {
                    final cell = field.cells.firstWhere(
                      (c) => c.row == rowIndex && c.column == columnIndex,
                    );

                    if (result.contains(cell) && !cell.isStart && !cell.isEnd) {
                      cell.color = const Color(0xFF4CAF50);
                    }

                    return DataCell(
                      Container(
                        width: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(color: cell.color),
                        child: Text(
                          '(${cell.row},${cell.column})',
                          style: TextStyle(
                            fontSize: 14,
                            color: cell.isBlocked ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
