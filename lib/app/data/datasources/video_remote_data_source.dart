import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:search_gold_quotes/app/data/models/video_items_model.dart';
import 'package:search_gold_quotes/core/error/exceptions.dart';
import 'package:search_gold_quotes/core/values/strings.dart';

abstract class VideoRemoteDataSource {
  Future<VideoListModel> getVideoList();
}

class VideoRemoteDataSourceImpl extends VideoRemoteDataSource {
  final Dio httpClient;

  VideoRemoteDataSourceImpl({@required this.httpClient});

  @override
  Future<VideoListModel> getVideoList() async {
    final response = await httpClient.get(apiURL);
    if (response.statusCode == 200) {
      try {
        return VideoListModel.fromJson(jsonDecode(response.data));
      } catch (exception) {
        throw ParseException();
      }
    } else {
      throw ServerException();
    }
  }
}
