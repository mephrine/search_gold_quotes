import 'package:dartz/dartz.dart';
import 'package:search_gold_quotes/app/domain/entities/video_items.dart';
import 'package:search_gold_quotes/core/error/failures.dart';
abstract class VideoRepository {
  Future<Either<Failure, VideoList>> getVideoList();
}