import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:search_gold_quotes/app/data/datasources/home_data_local_data_source.dart';
import 'package:search_gold_quotes/app/data/datasources/home_data_remote_data_source.dart';
import 'package:search_gold_quotes/app/domain/entities/home_data.dart';
import 'package:search_gold_quotes/app/domain/repositories/home_repository.dart';
import 'package:search_gold_quotes/core/error/failures.dart';
import 'package:search_gold_quotes/core/platform/network_info.dart';

class HomeRepositoryImpl extends HomeRepository {
  final NetworkInfo networkInfo;
  final HomeDataRemoteDataSource remoteDataSource;
  final HomeDataLocalDataSource localDataSource;

  HomeRepositoryImpl({
    @required this.networkInfo,
    @required this.remoteDataSource,
    @required this.localDataSource
  });

  @override
  Future<Either<Failure, HomeData>> getHomeData() async {
    bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      return Right(await remoteDataSource.getHomeData());
    } else {

    }
    return null;
  }
}