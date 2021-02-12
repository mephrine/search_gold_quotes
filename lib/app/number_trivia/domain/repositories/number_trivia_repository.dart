import 'package:dartz/dartz.dart';
import 'package:search_gold_quotes/core/error/failures.dart';
import 'package:search_gold_quotes/app/number_trivia/domain/entities/number_trivia.dart';

// 해당 부분이 Dart에서는 인터페이스
abstract class NumberTriviaRepository {
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int number);
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia();
}