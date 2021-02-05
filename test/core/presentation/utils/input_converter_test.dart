import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:search_gold_quotes/core/presentation/utils/input_converter.dart';

void main() {
  InputConverter inputConverter;
  setUp(() {
    inputConverter = InputConverter();
  });

  group('stringToUnsignedInteger', () {
    test('should return an integer when the string represents an unsigned integer', () async {
        // arrange
        final string = '123';
        // act
        final result = inputConverter.stringToUnsignedInteger(string);
        // assert
        expect(result, Right(123));
     });

    test('should return a failure when the string is not an integer', () async {
      // arrange
      final string = 'abc';
      // act
      final result = inputConverter.stringToUnsignedInteger(string);
      // assert
      expect(result, Left(InvalidInputFailure()));
    });
  });
}
