import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:search_gold_quotes/app/data/models/home_data_model.dart';
import 'package:search_gold_quotes/core/error/exceptions.dart';
import 'package:search_gold_quotes/core/values/constants.dart' as constants;

abstract class HomeDataRemoteDataSource {
  Future<HomeDataModel> getHomeData();
}


class HomeDataRemoteDataSourceImpl extends HomeDataRemoteDataSource {
  final Dio httpClient;

  HomeDataRemoteDataSourceImpl({
    @required this.httpClient
  });

  @override
  Future<HomeDataModel> getHomeData() async {
    final response = await httpClient.get(constants.famousSayingURL);
    if (response.statusCode == 200) {
      try {
        return HomeDataModel.fromJson(json.decode(response.data));
      } catch (exception) {
        throw ParseException();
      }
    } else {
      throw ServerException();
    }
    return null;
  }

}