import 'package:dartz/dartz.dart';
import 'package:search_gold_quotes/app/domain/entities/home_data.dart';
import 'package:search_gold_quotes/core/error/failures.dart';

abstract class HomeRepository {
  Future<Either<Failure, HomeData>> getHomeData();
}