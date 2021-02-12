import 'package:dartz/dartz.dart';
import 'package:search_gold_quotes/core/error/failures.dart';
import 'package:search_gold_quotes/features/price/domain/entities/home_data.dart';

abstract class HomeRepository {
  Future<Either<Failure, HomeData>> getHomeData();
}