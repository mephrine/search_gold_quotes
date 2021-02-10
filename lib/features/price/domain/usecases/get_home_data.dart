import 'package:dartz/dartz.dart';
import 'package:search_gold_quotes/core/error/failures.dart';
import 'package:search_gold_quotes/core/usecases/usecase.dart';
import 'package:search_gold_quotes/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:search_gold_quotes/features/price/domain/entities/home_data.dart';

class GetHomeInfo extends UseCase<HomeData, Params> {
  @override
  Future<Either<Failure, HomeData>> call(Params parms) {
    return null;
  }
}