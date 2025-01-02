import 'package:flutter/material.dart';
import 'package:webspark_test/presentation/widgets/home_widgets/form.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(
          'Home Screen',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Set valid API base url in order to continue',
            ),
            SizedBox(height: 8),
            UrlForm(),
          ],
        ),
      ),
    );
  }
}
