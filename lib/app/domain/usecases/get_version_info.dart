import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:search_gold_quotes/app/domain/entities/version_info.dart';
import 'package:search_gold_quotes/app/domain/repositories/version_repository.dart';
import 'package:search_gold_quotes/core/error/failures.dart';
import 'package:search_gold_quotes/core/usecases/no_params.dart';
import 'package:search_gold_quotes/core/usecases/usecase.dart';

class GetVersionInfo extends UseCase<VersionInfo, NoParams>  {
  VersionRepository repository;

  GetVersionInfo({
    @required this.repository
  });

  @override
  Future<Either<Failure, VersionInfo>> call(NoParams parms) async {
    return await repository.getVersionInfo();
  }
}