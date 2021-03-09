import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:search_gold_quotes/app/data/models/version_info_model.dart';
import 'package:search_gold_quotes/core/error/exceptions.dart';
import 'package:search_gold_quotes/core/values/constants.dart';

abstract class VersionRemoteDataSource {
  Future<VersionInfoModel> getVersionInfo();
}

class VersionRemoteDataSourceImpl extends VersionRemoteDataSource {
  final Dio httpClient;

  VersionRemoteDataSourceImpl({
    @required this.httpClient
  });

  @override
  Future<VersionInfoModel> getVersionInfo() async {
    try {
      final response = await httpClient.get(appInfoURL);
      if (response.statusCode == 200) {
        try {
          print("decodeData1 : $response.data");
          final decodeData = json.decode(response.data);
          print("decodeData : $decodeData");
          return VersionInfoModel.fromJson(decodeData);
        } catch (exception) {
          print('parseException : ' + exception.toString());
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