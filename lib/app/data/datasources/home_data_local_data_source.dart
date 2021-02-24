import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:search_gold_quotes/app/data/models/home_data_model.dart';
import 'package:search_gold_quotes/core/error/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class HomeDataLocalDataSource {
  Future<HomeDataModel> getLastHomeData();
  Future<void> cacheHomeData(HomeDataModel homeDataModel);
}

const String CACHED_MAIN_DATA = "CACHED_MAIN_DATA";
class HomeDataLocalDataSourceImpl extends HomeDataLocalDataSource {
  final SharedPreferences sharedPreferences;

  HomeDataLocalDataSourceImpl({
    @required this.sharedPreferences
  });

  @override
  Future<HomeDataModel> getLastHomeData() {
    final jsonString = sharedPreferences.getString(CACHED_MAIN_DATA);
    if(jsonString != null) {
      return Future.value(HomeDataModel.fromJSON(json.decode(jsonString)));
    }
    throw CacheException();
  }

  @override
  Future<void> cacheHomeData(HomeDataModel homeDataModel) async {
    final jsonString = json.encode(homeDataModel).toString();
    return await sharedPreferences.setString(CACHED_MAIN_DATA, jsonString);
  }

}