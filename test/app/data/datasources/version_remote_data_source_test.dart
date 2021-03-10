
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:search_gold_quotes/app/data/datasources/version_remote_data_source.dart';
import 'package:search_gold_quotes/app/data/models/version_info_model.dart';
import 'package:search_gold_quotes/core/error/exceptions.dart';
import 'package:search_gold_quotes/core/values/constants.dart';

import '../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements Dio {}

class MockConnectivity extends Mock implements Connectivity {}

void main() {
  MockHttpClient mockHttpClient;
  VersionRemoteDataSourceImpl remoteDataSource;

  setUp(() {
    mockHttpClient = MockHttpClient();
    remoteDataSource = VersionRemoteDataSourceImpl(httpClient: mockHttpClient);
  });

  group('device is connect', () {
    final versionInfoModel =
        VersionInfoModel(appVersion: '1.0.0', appVersionSeq: 1);
    test('check correct url', () async {
      // arrange
      when(mockHttpClient.get(any)).thenAnswer((realInvocation) async =>
          Response(statusCode: 200, data: fixture('version_info.json')));

      // act
      remoteDataSource.getVersionInfo();
      // assert
      verify(mockHttpClient.get(appInfoURL));
    });

    test('should return version info when the response code is 200', () async {
      // arrange
      when(mockHttpClient.get(any)).thenAnswer((realInvocation) async =>
          Response(statusCode: 200, data: fixture('version_info.json')));
      // act
      final result = await remoteDataSource.getVersionInfo();

      // assert
      verify(mockHttpClient.get(any));
      expect(result, versionInfoModel);
    });

    test('should return version info when the response code is 200 and invalid json', () async {
      // arrange
      when(mockHttpClient.get(any)).thenAnswer((realInvocation) async =>
          Response(statusCode: 200, data: fixture('trivia.json')));
      // act
      final emptyVersionInfo = await remoteDataSource.getVersionInfo();

      // assert
      expect(emptyVersionInfo, VersionInfoModel.empty());
      verify(mockHttpClient.get(any));
    });

    test('should return Parse Exception the response code is 200 and data is null', () async {
      // arrange
      when(mockHttpClient.get(any)).thenAnswer((realInvocation) async =>
          Response(statusCode: 200, data: null));

      // act
      final call = remoteDataSource.getVersionInfo;

      // assert
      expect(() => call(), throwsA(isInstanceOf<ServerException>()));
      verify(mockHttpClient.get(any));
    });

    test('should return Failure when the response code is 500', () async {
        // arrange
      when(mockHttpClient.get(any))
          .thenAnswer((_) async => Response(statusCode: 500, statusMessage: 'Server Error'));
        // act
      final call = remoteDataSource.getVersionInfo();

        // assert
      expect(() => call, throwsA(isInstanceOf<ServerException>()));
     });

  });
}
