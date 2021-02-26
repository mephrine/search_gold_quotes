import 'package:dartz/dartz.dart';
import 'package:search_gold_quotes/core/error/failures.dart';
import 'package:search_gold_quotes/app/domain/entities/video_item.dart';
abstract class VideoRepository {
  Future<Either<VideoItem, Failure>> getVideoList();
}