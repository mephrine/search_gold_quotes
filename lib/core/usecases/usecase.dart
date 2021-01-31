import 'package:dartz/dartz.dart';
import 'package:search_gold_quotes/core/error/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params parms);
}