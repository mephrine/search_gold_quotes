import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:search_gold_quotes/app/data/datasources/version_remote_data_source.dart';
import 'package:search_gold_quotes/app/data/models/version_info_model.dart';
import 'package:search_gold_quotes/app/data/repositories/version_repository_impl.dart';
import 'package:search_gold_quotes/core/error/exceptions.dart';
import 'package:search_gold_quotes/core/error/failures.dart';
import 'package:search_gold_quotes/core/platform/network_info.dart';


class MockVersionRemoteDataSource extends Mock implements VersionRemoteDataSource {}
class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  VersionRepositoryImpl repository;
  MockNetworkInfo networkInfo;
  MockVersionRemoteDataSource remoteDataSource;
  
  setUp(() {
    networkInfo = MockNetworkInfo();
    remoteDataSource = MockVersionRemoteDataSource();
    repository = VersionRepositoryImpl(networkInfo: networkInfo,remoteDataSource: remoteDataSource);
  });
  
  group('getVersionInfo is online', () {
    final versionInfoModel = VersionInfoModel(latestVersion: "1.0.0", forceUpdate: "Y");
    setUp(() {
      when(networkInfo.isConnected)
          .thenAnswer((_) async => true);
    });

    test('should return versionInfo when the call to version info datasource is successful', () async {
      // arrange
      when(remoteDataSource.getVersionInfo())
          .thenAnswer((_)  async => versionInfoModel);
      // act
      final result = await repository.getVersionInfo();

      // assert
      expect(result, Right(versionInfoModel));
    });

    test('should return error message when the call to version info datasource is failure', () async {
      // arrange
      when(remoteDataSource.getVersionInfo())
          .thenThrow(ServerException());

      // act
      final result = await repository.getVersionInfo();

      // assert
      verify(remoteDataSource.getVersionInfo());
      expect(result, equals(Left(ServerFailure())));
    });
  });

  group('getVersionInfo is offline', () {
    setUp(() {
      when(networkInfo.isConnected)
          .thenAnswer((_) async => false);
    });

    test('should return error message when the call to version info datasource is failure', () async {
      // act
      final result = await repository.getVersionInfo();

      // assert
      verifyNever(remoteDataSource.getVersionInfo());
      verifyZeroInteractions(remoteDataSource);
      expect(result, equals(Left(ServerFailure())));
    });
  });
}