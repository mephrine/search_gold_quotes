import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:search_gold_quotes/core/presentation/utils/input_converter.dart';
import 'package:search_gold_quotes/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:search_gold_quotes/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:search_gold_quotes/features/number_trivia/presentation/number_trivia/number_trivia_bloc.dart';

class MockGetConcreteNumberTrivia extends Mock implements GetConcreteNumberTrivia {}
class MockGetRandomNumberTrivia extends Mock implements GetRandomNumberTrivia {}
class MockInputConverter extends Mock implements InputConverter {}

void main() {
  NumberTriviaBloc numberTriviaBloc;
  MockGetConcreteNumberTrivia mockGetTriviaForConcreteNumber;
  MockGetRandomNumberTrivia mockGetTriviaForRandomNumber;
  MockInputConverter mockInputConverter;

  setUp(() {
    mockGetTriviaForConcreteNumber = MockGetConcreteNumberTrivia();
    mockGetTriviaForRandomNumber = MockGetRandomNumberTrivia();
    mockInputConverter = MockInputConverter();
    numberTriviaBloc = NumberTriviaBloc(
        concrete: mockGetTriviaForConcreteNumber,
        random: mockGetTriviaForRandomNumber,
        inputConverter: mockInputConverter);
  });

  group('', () {

  });
}