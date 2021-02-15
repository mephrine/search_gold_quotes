import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:search_gold_quotes/app/domain/entities/version_info.dart';
import 'package:search_gold_quotes/app/domain/repositories/version_repository.dart';
import 'package:search_gold_quotes/app/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:search_gold_quotes/core/error/failures.dart';
import 'package:search_gold_quotes/core/usecases/usecase.dart';

class GetVersionInfo extends UseCase<VersionInfo, NoParams>  {
  VersionRepository repository;

  GetVersionInfo({
    @required this.repository
  });

  @override
  Future<Either<Failure, VersionInfo>> call(NoParams parms) {
    return repository.getVersionInfo();
  }
}