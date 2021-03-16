import 'package:dartz/dartz.dart';
import 'package:search_gold_quotes/core/error/failures.dart';
import 'package:search_gold_quotes/app/domain/entities/history_jewelry.dart';

abstract class HistoryRepository {
  Future<Either<Failure, HistoryJewelry>> getHistoryData();
}
