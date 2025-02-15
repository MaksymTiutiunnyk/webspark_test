import 'package:flutter/material.dart';
import 'package:webspark_test/presentation/widgets/home_widgets/url_form.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home screen')),
      body: const Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Set valid API base url in order to continue',
            ),
            SizedBox(height: 12),
            UrlForm(),
          ],
        ),
      ),
    );
  }
}
