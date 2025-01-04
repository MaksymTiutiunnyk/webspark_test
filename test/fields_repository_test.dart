import 'package:flutter_test/flutter_test.dart';
import 'package:webspark_test/data/models/cell.dart';
import 'package:webspark_test/data/models/field.dart';
import 'package:webspark_test/data/repositories/fields_repository.dart';
import 'mock_fields_api.dart';

void main() {
  late MockFieldsApi mockFieldsApi;
  late FieldsRepository fieldsRepository;

  setUp(() {
    mockFieldsApi = MockFieldsApi();
    fieldsRepository = FieldsRepository(mockFieldsApi);
  });

  group('FieldsRepository.fetchData', () {
    test('should return a list of fields for valid URL', () async {
      final fields = await fieldsRepository.fetchData('valid_url');
      expect(fields, isNotEmpty);
      expect(fields.first.id, "1");
    });

    test('should throw an exception for invalid URL', () async {
      expect(
        () async => await fieldsRepository.fetchData('invalid_url'),
        throwsA(isA<Exception>()),
      );
    });
  });

  group('FieldsRepository.sendResults', () {
    test('should complete successfully for valid data', () async {
      final mockFields = [
        Field(
          id: "1",
          cells: [
            Cell.noColor(
              column: 0,
              row: 0,
              isBlocked: false,
              isStart: true,
              isEnd: false,
            ),
            Cell.noColor(
              column: 1,
              row: 0,
              isBlocked: false,
              isStart: false,
              isEnd: true,
            ),
            Cell.noColor(
              column: 0,
              row: 1,
              isBlocked: false,
              isStart: false,
              isEnd: false,
            ),
            Cell.noColor(
              column: 1,
              row: 1,
              isBlocked: false,
              isStart: false,
              isEnd: false,
            ),
          ],
          start: Cell.noColor(
            column: 0,
            row: 0,
            isBlocked: false,
            isStart: true,
            isEnd: false,
          ),
          end: Cell.noColor(
            column: 1,
            row: 0,
            isBlocked: false,
            isStart: false,
            isEnd: true,
          ),
          rows: 2,
          columns: 2,
        ),
      ];

      final mockResults = [
        [
          Cell.noColor(
              column: 0, row: 0, isBlocked: false, isStart: true, isEnd: false),
          Cell.noColor(
              column: 1, row: 0, isBlocked: false, isStart: false, isEnd: true),
        ],
      ];

      await expectLater(
        fieldsRepository.sendResults(
          fields: mockFields,
          results: mockResults,
          url: 'valid_url',
        ),
        completes,
      );
    });

    test('should throw an exception for bad request', () async {
      expect(
        () async => await fieldsRepository.sendResults(
          fields: [],
          results: [],
          url: 'invalid_url',
        ),
        throwsA(isA<Exception>()),
      );
    });
  });
}
