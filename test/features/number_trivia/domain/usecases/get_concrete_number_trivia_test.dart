import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:search_gold_quotes/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:search_gold_quotes/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:search_gold_quotes/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';

class MockNumberTriviaRepository extends Mock implements NumberTriviaRepository {

}

void main() {
  GetConcreteNumberTrivia usecase;
  MockNumberTriviaRepository mockNumberTriviaRepository;

  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    usecase = GetConcreteNumberTrivia(mockNumberTriviaRepository);
  });

  final testNumber = 1;
  final testNumberTrivia = NumberTrivia(number: 1, text: "test");
  
  test("should get trivia for the number from the repository", () async {
    // arrange
    when(mockNumberTriviaRepository.getConcreteNumberTrivia(any))
        .thenAnswer((_) async => Right(testNumberTrivia));

    // act
    final result = await usecase(Params(number: testNumber));

    // assert
    expect(result, Right(testNumberTrivia));
    verify(mockNumberTriviaRepository.getConcreteNumberTrivia(testNumber));
    verifyNoMoreInteractions(mockNumberTriviaRepository);

  });
}