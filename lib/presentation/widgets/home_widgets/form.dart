import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:webspark_test/presentation/screens/process.dart';

class UrlForm extends StatefulWidget {
  const UrlForm({super.key});

  @override
  State<UrlForm> createState() {
    return _UrlFormState();
  }
}

class _UrlFormState extends State<UrlForm> {
  final _formKey = GlobalKey<FormState>();
  String url = '';
  bool isFetching = false;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: [
                const Icon(Icons.compare_arrows),
                const SizedBox(width: 24),
                Expanded(
                  child: TextFormField(
                    validator: (value) {
                      const allowedUrl =
                          'https://flutter.webspark.dev/flutter/api';
                      if (value == null || value.isEmpty) {
                        return 'Please enter a valid URL';
                      }

                      if (value != allowedUrl) {
                        return 'URL is not allowed';
                      }

                      url = value;
                      return null;
                    },
                  ),
                ),
              ],
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              ),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  try {
                    setState(() {
                      isFetching = true;
                    });
                    final response = await http.get(Uri.parse(url));

                    if (!context.mounted) {
                      return;
                    }

                    if (response.statusCode == 200) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ProcessScreen(),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).clearSnackBars();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'Oops, ${response.statusCode} error happened'),
                        ),
                      );
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).clearSnackBars();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Oops, unexpected error'),
                      ),
                    );
                  } finally {
                    setState(() {
                      isFetching = false;
                    });
                  }
                }
              },
              child: !isFetching
                  ? const Text(
                      'Start counting process',
                      style: TextStyle(color: Colors.black),
                    )
                  : const CircularProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}
