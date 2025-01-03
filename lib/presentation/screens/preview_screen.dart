import 'package:flutter/material.dart';
import 'package:webspark_test/data/models/cell.dart';
import 'package:webspark_test/data/models/field.dart';

class PreviewScreen extends StatelessWidget {
  final Field field;
  final List<Cell> result;
  final String formattedPath;

  const PreviewScreen(
      {super.key,
      required this.field,
      required this.result,
      required this.formattedPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(
          'Preview screen',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
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
                  decoration: BoxDecoration(
                    color: cell.color,
                    border: Border.all(),
                  ),
                  child: Text(
                    '(${cell.row},${cell.column})',
                    style: TextStyle(
                        color: cell.isBlocked ? Colors.white : Colors.black),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.grey.shade400,
                    width: 2,
                  ),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    formattedPath,
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
