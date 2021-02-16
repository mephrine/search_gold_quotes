import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:search_gold_quotes/app/data/datasources/version_remote_data_source.dart';
import 'package:search_gold_quotes/app/domain/entities/version_info.dart';
import 'package:search_gold_quotes/app/domain/repositories/version_repository.dart';
import 'package:search_gold_quotes/core/error/exceptions.dart';
import 'package:search_gold_quotes/core/error/failures.dart';
import 'package:search_gold_quotes/core/platform/network_info.dart';

class VersionRepositoryImpl extends VersionRepository {
  final VersionRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  VersionRepositoryImpl({
    @required this.remoteDataSource,
    @required this.networkInfo
  });

  @override
  Future<Either<Failure, VersionInfo>> getVersionInfo() async {
    final isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final result = await remoteDataSource.getVersionInfo();
        return Right(result);
      } on ServerException {
        return Left(ServerFailure());
      }
    }
    return Left(ServerFailure());
  }
}