import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:search_gold_quotes/app/data/models/video_items_model.dart';
import 'package:search_gold_quotes/core/error/exceptions.dart';
import 'package:search_gold_quotes/core/values/constants.dart';

abstract class VideoRemoteDataSource {
  Future<VideoListModel> getVideoList();
}

class VideoRemoteDataSourceImpl extends VideoRemoteDataSource {
  final Dio httpClient;

  VideoRemoteDataSourceImpl({@required this.httpClient});

  @override
  Future<VideoListModel> getVideoList() async {
    try {
      final response = await httpClient.get(videoListURL);
      if (response.statusCode == 200) {
        try {
          return VideoListModel.fromJson(response.data);
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
