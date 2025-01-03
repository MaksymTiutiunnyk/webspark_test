import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webspark_test/data/data_providers/fields_api.dart';
import 'package:webspark_test/data/models/cell.dart';
import 'package:webspark_test/data/models/field.dart';
import 'package:webspark_test/data/repositories/fields_repository.dart';
import 'package:webspark_test/logic/cubit/url_cubit.dart';
import 'package:webspark_test/presentation/screens/result_list.dart';

class SendResultsButton extends StatefulWidget {
  final List<Field> fields;
  final List<List<Cell>> results;
  const SendResultsButton({
    super.key,
    required this.fields,
    required this.results,
  });

  @override
  State<SendResultsButton> createState() {
    return _SendResultsButtonState();
  }
}

class _SendResultsButtonState extends State<SendResultsButton> {
  bool _isSending = false;
  final _fieldsRepository = FieldsRepository(const FieldsApi());

  Future<void> _sendResultsToServer() async {
    setState(() {
      _isSending = true;
    });

    try {
      await _fieldsRepository.sendResults(
        fields: widget.fields,
        results: widget.results,
        url: context.read<UrlCubit>().state,
      );

      if (!mounted) {
        return;
      }
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ResultListScreen(
            widget.fields,
            widget.results,
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    } finally {
      setState(() {
        _isSending = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ElevatedButton(
        onPressed: _isSending
            ? null
            : () async {
                await _sendResultsToServer();
              },
        child: !_isSending
            ? const Text('Send results to server')
            : const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
