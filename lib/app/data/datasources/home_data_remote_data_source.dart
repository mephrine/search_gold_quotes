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


class HomeDataRemoteDataSourceImpl implements HomeDataRemoteDataSource {
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
          //Todo. test
          // return HomeDataModel.fromJson(response.data);
          return HomeDataModel.fromJson(json.decode(testData));
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

  final testData = """
  {
  "data": {
    "famousSayingSeq": 7,
    "famousSaying": "Gold is God",
    "famousSayingWriter": "aaa",
    "referenceSiteName": "https://www.naver.com",
    "goldList": [
      {
        "jewelryType": "G",
        "goldDate": "2021-02-10",
        "goldPurity": "100",
        "goldPriceType": "W",
        "goldPrice": "100000"
      } ,
      {
        "jewelryType": "G",
        "goldDate": "2021-02-09",
        "goldPurity": "70",
        "goldPriceType": "W",
        "goldPrice": "90000"
      } ,
      {
        "jewelryType": "G",
        "goldDate": "2021-02-08",
        "goldPurity": "100",
        "goldPriceType": "W",
        "goldPrice": "95000"
      }
    ]
  },
  "httpStatusCd": 200,
  "resultStatusCd": 200
}
  """;

}