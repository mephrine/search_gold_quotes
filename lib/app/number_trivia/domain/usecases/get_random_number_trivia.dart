import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:search_gold_quotes/core/error/failures.dart';
import 'package:search_gold_quotes/core/usecases/usecase.dart';
import 'package:search_gold_quotes/app/number_trivia/domain/entities/number_trivia.dart';
import 'package:search_gold_quotes/app/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:search_gold_quotes/app/number_trivia/domain/usecases/get_concrete_number_trivia.dart';

class GetRandomNumberTrivia extends UseCase<NumberTrivia, NoParams> {
  final NumberTriviaRepository numberTriviaRepository;

  GetRandomNumberTrivia(this.numberTriviaRepository);

  @override
  Future<Either<Failure, NumberTrivia>> call(NoParams parms) async {
    return await numberTriviaRepository.getRandomNumberTrivia();
  }
}

class NoParams extends Equatable {
  @override
  List<Object> get props => null;
}