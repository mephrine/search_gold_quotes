import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:search_gold_quotes/app/number_trivia/domain/entities/number_trivia.dart';
import 'package:search_gold_quotes/app/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:search_gold_quotes/core/error/failures.dart';
import 'package:search_gold_quotes/core/usecases/usecase.dart';

class GetConcreteNumberTrivia implements UseCase<NumberTrivia, Params> {
  final NumberTriviaRepository numberTriviaRepository;

  GetConcreteNumberTrivia(this.numberTriviaRepository);

  Future<Either<Failure, NumberTrivia>> call(
      Params params
      ) async {
    return await numberTriviaRepository.getConcreteNumberTrivia(params.number);
  }
}

class Params extends Equatable {
  final int number;

  Params({this.number});

  @override
  List<Object> get props => [number];
}