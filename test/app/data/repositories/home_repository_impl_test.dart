

import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:search_gold_quotes/app/data/datasources/home_data_local_data_source.dart';
import 'package:search_gold_quotes/app/data/datasources/home_data_remote_data_source.dart';
import 'package:search_gold_quotes/app/data/models/gold_model.dart';
import 'package:search_gold_quotes/app/data/models/home_data_model.dart';
import 'package:search_gold_quotes/app/data/repositories/home_repository_impl.dart';
import 'package:search_gold_quotes/core/error/exceptions.dart';
import 'package:search_gold_quotes/core/error/failures.dart';
import 'package:search_gold_quotes/core/platform/network_info.dart';

import '../../../fixtures/fixture_reader.dart';

class MockNetworkInfo extends Mock implements NetworkInfo {}
class MockHomeDataRemoteDataSource extends Mock implements HomeDataRemoteDataSource {}
class MockHomeDataLocalDataSource extends Mock implements HomeDataLocalDataSource {}

void main() {
  MockNetworkInfo networkInfo;
  MockHomeDataRemoteDataSource remoteDataSource;
  MockHomeDataLocalDataSource localDataSource;
  HomeRepositoryImpl homeRepository;

  setUp(() {
    networkInfo = MockNetworkInfo();
    remoteDataSource = MockHomeDataRemoteDataSource();
    localDataSource = MockHomeDataLocalDataSource();

    homeRepository = HomeRepositoryImpl(networkInfo: networkInfo, remoteDataSource: remoteDataSource, localDataSource: localDataSource);
  });

  group('network is connected', () {
    final goldList = [
      GoldModel(jewelryType: 'G', goldDate: '2021-02-10', goldPurity: '100', goldPriceType: 'W', goldPrice: '100000'),
      GoldModel(jewelryType: 'G', goldDate: '2021-02-09', goldPurity: '70', goldPriceType: 'W', goldPrice: '90000'),
      GoldModel(jewelryType: 'G', goldDate: '2021-02-08', goldPurity: '100', goldPriceType: 'W', goldPrice: '95000'),
    ];
    final homeDataModel = HomeDataModel(famousQuotes: 'Gold is God', referenceSiteName: 'https://www.naver.com', goldList: goldList);

    setUp(() {
      when(networkInfo.isConnected)
          .thenAnswer((_)  async => true);
    });

    test('verify check the network is connected', () async {
      // act
      await homeRepository.getHomeData();

      // assert
      verify(networkInfo.isConnected);
    });

    test('should return a model when network is connected', () async {
      // arrange
      when(remoteDataSource.getHomeData())
        .thenAnswer((_) async => HomeDataModel.fromJSON(json.decode(fixture('home_data.json'))));

      // act
      final result = await remoteDataSource.getHomeData();

      // assert
      expect(result, homeDataModel);
    });

    test('should return ServerError when the call to main data repository is failure', () async {
      // arrange
      when(remoteDataSource.getHomeData())
          .thenThrow(ServerException());
      // act
      final result = await homeRepository.getHomeData();

      // assert
      verify(remoteDataSource.getHomeData());
      expect(result, Left(ServerFailure()));
    });
    
    test('should return ParseException when the call to main data repositoiry data is null', () async {
        // arrange
        when(remoteDataSource.getHomeData())
            .thenThrow(ParseException());
        // act
      final result = await homeRepository.getHomeData();
    
        // assert
      expect(result, Left(ParseFailure()));
     });

  });

  group('network is connected', () {
    setUp((){
      when(networkInfo.isConnected)
          .thenAnswer((_) async => false);
    });

    test('should return ServerFailure when network is disconnected', () async {
        // act
      final result = await homeRepository.getHomeData();

        // assert
      expect(result, Left(ServerFailure()));
     });

    test('should get local cache when server failure', () async {
      // arrange
      when(remoteDataSource.getHomeData())
          .thenThrow((_) => ServerException());
      // act
      final call = await homeRepository.getHomeData();

      // assert
      expect(() => call, throwsA(isInstanceOf<ServerException>()));
    });
  });
}