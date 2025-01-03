import 'package:flutter/material.dart';
import 'package:webspark_test/data/models/cell.dart';
import 'package:webspark_test/data/models/field.dart';
import 'package:webspark_test/presentation/widgets/result_list_widgets/single_result.dart';

class ResultListScreen extends StatelessWidget {
  final List<Field> fields;
  final List<List<Cell>> results;
  const ResultListScreen(this.fields, this.results, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(
          'Result list screen',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => SingleResult(
          fields[index],
          results[index],
        ),
        itemCount: results.length,
      ),
    );
  }
}
