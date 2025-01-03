import 'package:flutter/material.dart';
import 'package:webspark_test/data/models/cell.dart';
import 'package:webspark_test/data/models/field.dart';
import 'package:webspark_test/presentation/widgets/preview_widgets/field_grid.dart';
import 'package:webspark_test/presentation/widgets/preview_widgets/large_field_grid.dart';

class PreviewScreen extends StatelessWidget {
  final Field field;
  final List<Cell> result;
  final String formattedPath;

  const PreviewScreen({
    super.key,
    required this.field,
    required this.result,
    required this.formattedPath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Preview screen')),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            field.columns < 10
                ? FieldGrid(field: field, result: result)
                : LargeFieldGrid(field: field, result: result),
            SizedBox(
              width: double.infinity,
              child: Text(
                formattedPath,
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
