import 'package:flutter/material.dart';
import 'package:webspark_test/data/models/cell.dart';
import 'package:webspark_test/data/models/field.dart';
import 'package:webspark_test/presentation/screens/preview_screen.dart';

class SingleResult extends StatelessWidget {
  final Field field;
  final List<Cell> result;
  const SingleResult(this.field, this.result, {super.key});

  @override
  Widget build(BuildContext context) {
    final path =
        result.map((cell) => '(${cell.row}.${cell.column})').join(' -> ');

    return InkWell(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PreviewScreen(
          field: field,
          result: result,
          formattedPath: path,
        ),
      )),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade300),
          ),
        ),
        child: Text(
          path,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
