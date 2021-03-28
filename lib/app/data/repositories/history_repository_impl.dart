import 'package:dartz/dartz.dart';
import 'package:search_gold_quotes/app/data/datasources/history_remote_data_source.dart';
import 'package:search_gold_quotes/app/domain/entities/history_jewelry.dart';
import 'package:search_gold_quotes/app/domain/repositories/history_repository.dart';
import 'package:search_gold_quotes/app/domain/usecases/get_searched_price_history.dart';
import 'package:search_gold_quotes/core/error/failures.dart';
import 'package:meta/meta.dart';
import 'package:search_gold_quotes/core/platform/network_info.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  final HistoryRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  HistoryRepositoryImpl(
      {@required this.remoteDataSource, @required this.networkInfo});

  @override
  Future<Either<Failure, HistoryJewelryList>> getHistoryData(
      Params params) async {
    final isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final historyData = await remoteDataSource.getHistoryData(params);
        return Right(historyData);
      } catch (excepiton) {
        return Left(ServerFailure());
      }
    }
    return Left(ServerFailure());
  }
}
