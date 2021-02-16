import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:meta/meta.dart';
import 'package:dio/dio.dart';
import 'package:search_gold_quotes/app/data/models/version_info_model.dart';
import 'package:dartz/dartz.dart';
import 'package:search_gold_quotes/core/platform/device_utils.dart' as DeviceUtils;

abstract class VersionRemoteDataSource {
  Future<VersionInfoModel> getVersionInfo();
}

class VersionRemoteDataSourceImpl extends VersionRemoteDataSource {
  final url = "https://www.naver.com";
  final Dio httpClient;

  VersionRemoteDataSourceImpl({
    @required this.httpClient
  });

  @override
  Future<VersionInfoModel> getVersionInfo() async {
    final response = await httpClient.get(url);
    return VersionInfoModel.fromJson(json.decode(response.data));
  }

}