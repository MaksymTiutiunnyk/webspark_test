import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webspark_test/data/data_providers/fields_api.dart';
import 'package:webspark_test/data/repositories/fields_repository.dart';
import 'package:webspark_test/logic/cubit/percentage_cubit.dart';
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
  final fieldsRepository = FieldsRepository(const FieldsApi());

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.compare_arrows,
                  color: Colors.grey,
                ),
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
              onPressed: isFetching
                  ? null
                  : () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          setState(() {
                            isFetching = true;
                          });

                          final fields = await fieldsRepository.fetchData(url);

                          if (!context.mounted) {
                            return;
                          }
                          context.read<PercentageCubit>().resetProcessedCells();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProcessScreen(fields: fields),
                            ),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).clearSnackBars();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(e.toString())),
                          );
                        } finally {
                          setState(() {
                            isFetching = false;
                          });
                        }
                      }
                    },
              child: !isFetching
                  ? const Text('Start counting process')
                  : const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
