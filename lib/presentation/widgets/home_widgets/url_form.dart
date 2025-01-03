import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webspark_test/data/data_providers/fields_api.dart';
import 'package:webspark_test/data/repositories/fields_repository.dart';
import 'package:webspark_test/logic/cubit/percentage_cubit.dart';
import 'package:webspark_test/logic/cubit/url_cubit.dart';
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
  final TextEditingController _urlController = TextEditingController();
  bool _isFetching = false;
  final _fieldsRepository = FieldsRepository(const FieldsApi());

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
                    controller: _urlController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please, enter a URL';
                      }
                      if (!_isValidUrl(value)) {
                        return 'Please, enter a valid URL';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: _isFetching
                  ? null
                  : () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          _isFetching = true;
                        });

                        try {
                          context.read<UrlCubit>().setUrl(_urlController.text);
                          final fields = await _fieldsRepository
                              .fetchData(_urlController.text);

                          if (!context.mounted) return;
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
                            _isFetching = false;
                          });
                        }
                      }
                    },
              child: !_isFetching
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

  bool _isValidUrl(String url) {
    final uri = Uri.tryParse(url);
    return uri != null && uri.hasScheme && uri.hasAuthority;
  }

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }
}
