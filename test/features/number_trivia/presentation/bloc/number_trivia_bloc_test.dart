import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:search_gold_quotes/core/presentation/utils/input_converter.dart';
import 'package:search_gold_quotes/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:search_gold_quotes/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:search_gold_quotes/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:search_gold_quotes/features/number_trivia/presentation/number_trivia/number_trivia_bloc.dart';

class MockGetConcreteNumberTrivia extends Mock
    implements GetConcreteNumberTrivia {}

class MockGetRandomNumberTrivia extends Mock implements GetRandomNumberTrivia {}

class MockInputConverter extends Mock implements InputConverter {}

void main() {
  NumberTriviaBloc numberTriviaBloc;
  MockGetConcreteNumberTrivia mockGetConcreteNumberTrivia;
  MockGetRandomNumberTrivia mockGetRandomNumberTrivia;
  MockInputConverter mockInputConverter;

  setUp(() {
    mockGetConcreteNumberTrivia = MockGetConcreteNumberTrivia();
    mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
    mockInputConverter = MockInputConverter();
    numberTriviaBloc = NumberTriviaBloc(
        concrete: mockGetConcreteNumberTrivia,
        random: mockGetRandomNumberTrivia,
        inputConverter: mockInputConverter);
  });

  test('initialState should be Empty ', () async {
    // assert
    expect(numberTriviaBloc.initialState, equals(Empty()));
  });

  group('GetTriviaForConcreteNumber', () {
    final testNumberString = '1';
    final testParsedNumber = 1;
    final numberTrivia = NumberTrivia(number: 1, text: 'TEST TEXT');
    test(
        'should call the inputConverter to validate and convert the string to an unsigned integer.',
        () async {
      // arrange
      when(mockInputConverter.stringToUnsignedInteger(any))
          .thenReturn(Right(testParsedNumber));
      // act
      numberTriviaBloc.add(GetTriviaForConcreteNumber(testNumberString));
      await untilCalled(mockInputConverter.stringToUnsignedInteger(any));
      // assert
      verify(mockInputConverter.stringToUnsignedInteger(testNumberString));
    });

    test('should emit [Error] when the input is invalid.', () async {
      // arrange
      when(mockInputConverter.stringToUnsignedInteger(any))
          .thenReturn(Left(InvalidInputFailure()));

      // act
      numberTriviaBloc.add(GetTriviaForConcreteNumber(testNumberString));

      // assert later. is Stream
      final expected = [
        Error(message: INVALID_INPUT_FAILURE_MESSAGE)
      ];
      expectLater(numberTriviaBloc, emitsInOrder(expected));
    });

    test('should get data from the concrete use case', () async {
        // arrange
      when(mockInputConverter.stringToUnsignedInteger(any))
          .thenReturn(Right(testParsedNumber));
      when(mockGetConcreteNumberTrivia(any))
          .thenAnswer((_) async => Right(numberTrivia));
        // act
      numberTriviaBloc.add(GetTriviaForConcreteNumber(testNumberString));
      await untilCalled(mockGetConcreteNumberTrivia(any));

        // assert
      verify(mockGetConcreteNumberTrivia(Params(number: testParsedNumber)));
     });
  });
}
