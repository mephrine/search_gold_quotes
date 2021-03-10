import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:retrofit/http.dart';
import 'package:search_gold_quotes/app/data/models/home_data_model.dart';
import 'package:search_gold_quotes/core/error/exceptions.dart';
import 'package:search_gold_quotes/core/values/constants.dart' as constants;
import 'package:search_gold_quotes/core/extensions/dio_response.dart';

abstract class HomeDataRemoteDataSource {
  @GET("/api/appVersion")
  Future<HomeDataModel> getHomeData();
}


class HomeDataRemoteDataSourceImpl extends HomeDataRemoteDataSource {
  final Dio httpClient;

  HomeDataRemoteDataSourceImpl({
    @required this.httpClient
  });

  @override
  Future<HomeDataModel> getHomeData() async {
    try {
      final response = await httpClient.get(constants.famousSayingURL);
      if (response.validateResponseData) {
        try {
          return HomeDataModel.fromJson(response.data);
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