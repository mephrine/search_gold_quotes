import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:search_gold_quotes/app/data/datasources/video_remote_data_source.dart';
import 'package:search_gold_quotes/app/data/models/video_items_model.dart';
import 'package:search_gold_quotes/core/error/exceptions.dart';

import '../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements Dio {}

void main() {
  MockHttpClient httpClient;
  VideoRemoteDataSourceImpl remoteDataSource;

  setUp(() {
    httpClient = MockHttpClient();
    remoteDataSource = VideoRemoteDataSourceImpl(httpClient: httpClient);
  });

  group('VideoRemoteDataSourceImpl', () {
    VideoListModel videoList;
    setUp(() {
      videoList = VideoListModel(itemList: [
        VideoItemModel(
            title: 'Video1',
            subTitle: 'SubTitle1',
            linkURL: 'https://www.naver.com',
            imagePath: 'https://lottiefiles.com/10203-gold'),
        VideoItemModel(
            title: 'Video2',
            subTitle: 'SubTitle2',
            linkURL: 'https://www.daum.net',
            imagePath: 'https://lottiefiles.com/10204-gold'),
        VideoItemModel(
            title: 'Video3',
            subTitle: 'SubTitle3',
            linkURL: 'https://www.nate.com',
            imagePath: 'https://lottiefiles.com/10205-gold')
      ]);
    });

    test('StatusCode 가 200(성공)일 때, VideoListModel 반환', () async {
      // arrange
      when(httpClient.get(any)).thenAnswer((_) async =>
          Response(statusCode: 200, data: json.decode(fixture('video.json'))));
      // act
      final result = await remoteDataSource.getVideoList();

      // assert
      expect(result, videoList);
    });

    test('response가 잘못된 json model인 경우, 빈 데이터 모델을 반환', () async {
      // arrange
      when(httpClient.get(any)).thenAnswer((realInvocation) async =>
          Response(statusCode: 200, data: json.decode(fixture('trivia.json'))));
      // act
      final emptyVideoModel = await remoteDataSource.getVideoList();

      // assert
      expect(emptyVideoModel, VideoListModel.empty());
    });

    test(
        'StatusCode 가 200(성공)이고, response data가 null을 반환했을 때, ParseException 발생',
        () async {
      // arrange
      when(httpClient.get(any))
          .thenAnswer((_) async => Response(statusCode: 200, data: null));
      // act
      final call = remoteDataSource.getVideoList();

      // assert
      expect(() => call, throwsA(isInstanceOf<ServerException>()));
    });

    test('StatusCode 가 500(실패)일 때, ServerException 발생', () async {
      // arrange
      when(httpClient.get(any)).thenAnswer(
          (_) async => Response(statusCode: 500, statusMessage: '일시적인 에러'));
      // act
      final call = remoteDataSource.getVideoList();

      // assert
      expect(() => call, throwsA(isInstanceOf<ServerException>()));
    });
  });
}
