import 'package:flutter/material.dart';

class UrlForm extends StatefulWidget {
  const UrlForm({super.key});

  @override
  State<UrlForm> createState() {
    return _UrlFormState();
  }
}

class _UrlFormState extends State<UrlForm> {
  final _formKey = GlobalKey<FormState>();

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
                      if (value == null || value.isEmpty) {
                        return 'Please, enter valid URL';
                      }
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
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                }
              },
              child: const Text(
                'Start counting process',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
