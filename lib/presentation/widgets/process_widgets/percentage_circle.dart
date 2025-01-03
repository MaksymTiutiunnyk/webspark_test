import 'package:flutter/material.dart';

class PercentageCircle extends StatelessWidget {
  final int percentage;
  const PercentageCircle(this.percentage, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      height: 120,
      child: CircularProgressIndicator(
        value: percentage / 100,
        strokeWidth: 4,
        color: Theme.of(context).colorScheme.inversePrimary,
      ),
    );
  }
}
