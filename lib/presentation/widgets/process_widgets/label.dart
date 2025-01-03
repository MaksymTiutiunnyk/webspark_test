import 'package:flutter/material.dart';

class Label extends StatelessWidget {
  final int percentage;
  const Label(this.percentage, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: percentage == 100
          ? const Text(
              'All calculations have been finished, you can send your results to server',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            )
          : const Text(
              'Calculations in progress...',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24),
            ),
    );
  }
}
