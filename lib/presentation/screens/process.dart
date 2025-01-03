import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webspark_test/data/models/cell.dart';
import 'package:webspark_test/data/models/field.dart';
import 'package:webspark_test/logic/cubit/percentage_cubit.dart';
import 'package:webspark_test/logic/shortest_path_finder.dart';
import 'package:webspark_test/presentation/widgets/process_widgets/label.dart';
import 'package:webspark_test/presentation/widgets/process_widgets/percentage_circle.dart';
import 'package:webspark_test/presentation/widgets/process_widgets/percentage_container.dart';
import 'package:webspark_test/presentation/widgets/process_widgets/send_results_button.dart';

class ProcessScreen extends StatelessWidget {
  final List<Field> fields;
  final int totalCells;
  final List<List<Cell>> _results = [];
  ProcessScreen({super.key, required this.fields})
      : totalCells = fields.fold(0, (sum, field) => sum + field.cells.length);

  Future<void> _startCalculations(BuildContext context) async {
    for (int i = 0; i < fields.length; ++i) {
      await Future.delayed(const Duration(seconds: 2));

      if (!context.mounted) {
        return;
      }
      final result = ShortestPathFinder(fields[i], context).findShortestPath();

      _results.add(result
          .map((element) => fields[i].cells.firstWhere((cell) =>
              cell.column == element['x'] && cell.row == element['y']))
          .toList());
    }
  }

  @override
  Widget build(BuildContext context) {
    _startCalculations(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Process screen')),
      body: BlocBuilder<PercentageCubit, int>(
        builder: (context, state) {
          int percentage = (state / totalCells * 100).toInt();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Label(percentage),
                    PercentageContainer(percentage),
                    const SizedBox(height: 16),
                    PercentageCircle(percentage),
                  ],
                ),
              ),
              if (percentage == 100)
                SendResultsButton(fields: fields, results: _results),
            ],
          );
        },
      ),
    );
  }
}
