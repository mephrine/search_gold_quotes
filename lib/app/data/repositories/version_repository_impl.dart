import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:search_gold_quotes/app/data/datasources/version_remote_data_source.dart';
import 'package:search_gold_quotes/app/domain/entities/version_info.dart';
import 'package:search_gold_quotes/app/domain/repositories/version_repository.dart';
import 'package:search_gold_quotes/core/error/failures.dart';

class VersionRepositoryImpl extends VersionRepository {
  VersionRemoteDataSource remoteDataSource;

  VersionRepositoryImpl({
    @required this.remoteDataSource
  });

  @override
  Future<Either<Failure, VersionInfo>> getVersionInfo() async {
    return Right(await remoteDataSource.getVersionInfo());
  }

}