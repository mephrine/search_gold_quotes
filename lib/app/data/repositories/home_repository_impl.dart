import 'package:dartz/dartz.dart';
import 'package:search_gold_quotes/app/domain/entities/home_data.dart';
import 'package:search_gold_quotes/app/domain/repositories/home_repository.dart';
import 'package:search_gold_quotes/core/error/failures.dart';

class HomeRepositoryImpl extends HomeRepository {
  @override
  Future<Either<Failure, HomeData>> getHomeData() {
    return null;
  }
}