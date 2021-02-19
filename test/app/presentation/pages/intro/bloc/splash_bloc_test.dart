


import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:search_gold_quotes/app/data/models/version_info_model.dart';
import 'package:search_gold_quotes/app/domain/entities/version_info.dart';
import 'package:search_gold_quotes/app/domain/usecases/get_version_info.dart';
import 'package:search_gold_quotes/app/presentation/pages/intro/bloc/bloc.dart';

import '../../../../../fixtures/fixture_reader.dart';

class MockGetVersionInfo extends Mock implements GetVersionInfo {}

void main() {
  SplashBloc splashBloc;
  MockGetVersionInfo mockGetVersionInfo;

  setUp(() {
    mockGetVersionInfo = MockGetVersionInfo();
    splashBloc = SplashBloc(versionInfo: mockGetVersionInfo);
  });

  test('isInitialize', () {
    expect(splashBloc.initialState, Empty());
  });

  group('GetVersionInfoForUpdate Usecase', () {
    final versionInfoModel = VersionInfo(latestVersion: '1.0.0', forceUpdate: 'Y');
    test('should return GetVersionInfo when splash page is loaded', () async {
      // arrange
      when(mockGetVersionInfo(any))
          .thenAnswer((_) async => Right(versionInfoModel));

      // act
      splashBloc.add(GetVersionInfoForUpdate());

      // assert
      expect(splashBloc.state, Loading());

    });
  });
}