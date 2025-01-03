import 'package:flutter/material.dart';

class PercentageContainer extends StatelessWidget {
  final int percentage;
  const PercentageContainer(this.percentage, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 1,
            spreadRadius: 0.1,
            offset: const Offset(0, 0.6),
          ),
        ],
      ),
      width: double.infinity,
      child: Text(
        '$percentage%',
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 24),
      ),
    );
  }
}
