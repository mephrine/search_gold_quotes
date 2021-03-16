import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:search_gold_quotes/app/data/datasources/home_data_remote_data_source.dart';
import 'package:search_gold_quotes/app/data/models/gold_model.dart';
import 'package:search_gold_quotes/app/data/models/home_data_model.dart';
import 'package:search_gold_quotes/core/error/exceptions.dart';

import '../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements Dio {}

void main() {
  MockHttpClient httpClient;
  HomeDataRemoteDataSource remoteDataSource;

  setUp(() {
    httpClient = MockHttpClient();
    remoteDataSource = HomeDataRemoteDataSourceImpl(httpClient: httpClient);
  });

  group('HomeDataRemoteDateSource', () {
    final goldList = [
      GoldModel(
          jewelryType: 'G',
          goldDate: '2021-02-10',
          goldPurity: '100',
          goldPriceType: 'W',
          goldPrice: '100000'),
      GoldModel(
          jewelryType: 'G',
          goldDate: '2021-02-09',
          goldPurity: '70',
          goldPriceType: 'W',
          goldPrice: '90000'),
      GoldModel(
          jewelryType: 'G',
          goldDate: '2021-02-08',
          goldPurity: '100',
          goldPriceType: 'W',
          goldPrice: '95000'),
    ];
    final homeDataModel = HomeDataModel(
        famousQuotes: 'Gold is God',
        famousSayingWriter: 'aaa',
        referenceSiteName: 'https://www.naver.com',
        goldList: goldList);

    HomeDataModel testHomeDataModel;
    setUp(() {
    });

    test('should return home data when the request code is 200', () async {
      // arrange
      when(httpClient.get(any))
          .thenAnswer((_) async => Response(statusCode: 200, data: json.decode(fixture('home_data.json'))));
      // act
      final result = await remoteDataSource.getHomeData();
      // assert
      expect(result, homeDataModel);
    });

    test('response가 잘못된 json model인 경우, 빈 데이터 모델을 반환', () async {
      // arrange
      when(httpClient.get(any))
          .thenAnswer((realInvocation) async => Response(statusCode: 200, data: json.decode(fixture('trivia.json'))));
      // act
      final emptyVideoModel = await remoteDataSource.getHomeData();

      // assert
      expect(emptyVideoModel, HomeDataModel.empty());
    });


    test('should return ParseException  when the response data is null', () async {
      // arrange
      when(httpClient.get(any))
          .thenAnswer((_) async => Response(statusCode: 200, data: null));
      // act
      final call = remoteDataSource.getHomeData();
      // assert
      expect(() => call, throwsA(isInstanceOf<ServerException>()));
    });

    test('should return ServerException when the request code is 500', () async {
      // arrange
      when(httpClient.get(any))
          .thenAnswer((_) async => Response(statusCode: 500, data: null));
      // act
      final call = remoteDataSource.getHomeData();
      // assert
      expect(() => call, throwsA(isInstanceOf<ServerException>()));
    });
  });
}
