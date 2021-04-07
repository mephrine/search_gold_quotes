import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:search_gold_quotes/app/data/models/version_info_model.dart';
import 'package:search_gold_quotes/core/error/exceptions.dart';
import 'package:search_gold_quotes/core/values/constants.dart';
import 'package:search_gold_quotes/core/extensions/dio_response_extension.dart';

abstract class VersionRemoteDataSource {
  Future<VersionInfoModel> getVersionInfo();
}

class VersionRemoteDataSourceImpl implements VersionRemoteDataSource {
  final Dio httpClient;

  VersionRemoteDataSourceImpl({@required this.httpClient});

  @override
  Future<VersionInfoModel> getVersionInfo() async {
    try {
      final response = await httpClient.get(Constants.appInfoURL);
      if (response.validateResponseData) {
        try {
          return VersionInfoModel.fromJson(response.data);
        } catch (exception) {
          throw ParseException();
        }
      } else {
        throw ServerException();
      }
    } catch (exception) {
      throw ServerException();
    }
  }
}
