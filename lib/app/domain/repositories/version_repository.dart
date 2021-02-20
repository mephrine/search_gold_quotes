
import 'package:dartz/dartz.dart';
import 'package:search_gold_quotes/app/domain/entities/version_info.dart';
import 'package:search_gold_quotes/core/error/failures.dart';

abstract class VersionRepository {
  Future<Either<Failure, VersionInfo>> getVersionInfo();
}