import 'package:flutter/material.dart';

class ResultListScreen extends StatelessWidget {
  const ResultListScreen({super.key});

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
    );
  }
}
