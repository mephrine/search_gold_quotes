import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:search_gold_quotes/app/data/datasources/version_remote_data_source.dart';
import 'package:search_gold_quotes/app/data/models/version_info_model.dart';
import 'package:search_gold_quotes/app/data/repositories/version_repository_impl.dart';
import 'package:search_gold_quotes/core/error/exceptions.dart';


class MockVersionRemoteDataSource extends Mock implements VersionRemoteDataSource {}

void main() {
  VersionRepositoryImpl repository;
  MockVersionRemoteDataSource remoteDataSource;
  
  setUp(() {
    remoteDataSource = MockVersionRemoteDataSource();
    repository = VersionRepositoryImpl(remoteDataSource: remoteDataSource);
  });
  
  group('getVersionInfo is successful', () {
    final versionInfoModel = VersionInfoModel(latestVersion: "1.0.0", forceUpdate: "Y");
    test('should return versionInfo when the call to version info datasource is successful', () async {
      // arrange
      when(remoteDataSource.getVersionInfo())
          .thenAnswer((_)  async => versionInfoModel);
      // act
      final result = await repository.getVersionInfo();

      // assert
      expect(result, Right(versionInfoModel));
    });


  });

  group('getVersionInfo is Failure', () {
    test('should return error message when the call to version info datasource is failure', () {
      // arrange
      when(remoteDataSource.getVersionInfo())
          .thenThrow(ServerException());

      // act
      final result = repository.getVersionInfo();

      // assert
      expect(result, throwsA(ServerException()));
    });
  });
}