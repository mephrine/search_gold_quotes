
import 'package:search_gold_quotes/app/data/models/version_info_model.dart';
import 'package:dartz/dartz.dart';

abstract class VersionRemoteDataSource {
  Future<VersionInfoModel> getVersionInfo();
}