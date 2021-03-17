import 'package:dartz/dartz.dart';
import 'package:search_gold_quotes/app/data/datasources/history_remote_data_source.dart';
import 'package:search_gold_quotes/app/domain/entities/history_jewelry.dart';
import 'package:search_gold_quotes/app/domain/repositories/history_repository.dart';
import 'package:search_gold_quotes/core/error/failures.dart';
import 'package:meta/meta.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  final HistoryRemoteDataSource remoteDataSource;

  HistoryRepositoryImpl({@required this.remoteDataSource});

  @override
  Future<Either<Failure, List<HistoryJewelry>>> getHistoryData() {
    return null;
  }
}
