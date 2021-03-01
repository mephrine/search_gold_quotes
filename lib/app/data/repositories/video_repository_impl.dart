import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:search_gold_quotes/app/data/datasources/video_remote_data_source.dart';
import 'package:search_gold_quotes/app/domain/entities/video_items.dart';
import 'package:search_gold_quotes/app/domain/repositories/video_repository.dart';
import 'package:search_gold_quotes/core/error/exceptions.dart';
import 'package:search_gold_quotes/core/error/failures.dart';
import 'package:search_gold_quotes/core/platform/network_info.dart';

class VideoRepositoryImpl extends VideoRepository {
  final NetworkInfo networkInfo;
  final VideoRemoteDataSource dataSource;


  VideoRepositoryImpl({
    @required this.networkInfo,
    @required this.dataSource
  });


  @override
  Future<Either<Failure, VideoList>> getVideoList() async {
    bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final videoList = await dataSource.getVideoList();
        return Right(videoList);
      } on ServerException {
        return Left(ServerFailure());
      } on ParseException {
        return Left(ParseFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

}