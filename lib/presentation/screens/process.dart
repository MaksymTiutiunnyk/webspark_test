import 'package:flutter/material.dart';
import 'package:webspark_test/data/models/field.dart';
import 'package:webspark_test/logic/shortest_path_finder.dart';
import 'package:webspark_test/presentation/screens/result_list.dart';

class ProcessScreen extends StatefulWidget {
  final List<Field> fields;
  const ProcessScreen({super.key, required this.fields});

  @override
  State<ProcessScreen> createState() => _ProcessScreenState();
}

class _ProcessScreenState extends State<ProcessScreen> {
  int percentage = 50;
  bool isSending = false;

  @override
  Widget build(BuildContext context) {
    for (final field in widget.fields) {
      final shortestPathFinder = ShortestPathFinder(field);
      print(shortestPathFinder.findShortestPath());
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(
          'Process screen',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: percentage == 100
                      ? const Text(
                          'All calculations has finished, you can send your results to server',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18),
                        )
                      : const Text(
                          'Calculations in progress...',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 24),
                        ),
                ),
                Container(
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
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: 120,
                  height: 120,
                  child: CircularProgressIndicator(
                    value: percentage / 100,
                    strokeWidth: 4,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
              ],
            ),
          ),
          if (percentage == 100)
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                ),
                onPressed: () {
                  setState(() {
                    isSending = true;
                  });

                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ResultListScreen(),
                    ),
                  );
                },
                child: !isSending
                    ? const Text(
                        'Send results to server',
                        style: TextStyle(color: Colors.black),
                      )
                    : const CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
