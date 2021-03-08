import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:search_gold_quotes/app/data/models/version_info_model.dart';
import 'package:search_gold_quotes/app/domain/entities/version_info.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  VersionInfoModel versionInfoModel;
  setUp(() {
    versionInfoModel =
        VersionInfoModel(appVersion: "1.0.0", appVersionSeq: 1);
  });

  test('should be a subclass of a VersionInfo', () async {
    expect(versionInfoModel, isA<VersionInfo>());
  });

  group('fromJson', () {
    test('should return a valid model json appVersionSeq is int', () async {
      // arrange
      final jsonMap = json.decode(fixture('version_info.json'));
      // act
      final result = VersionInfoModel.fromJson(jsonMap);
      // assert
      expect(result, versionInfoModel);
    });

    test('should return null when the json key is invalid', () async {
      // arrange
      final jsonMap = json.decode(fixture('trivia.json'));
      // act
      final resultVersionInfoModel = VersionInfoModel.fromJson(jsonMap).appVersionSeq;
      // assert
      expect(resultVersionInfoModel, 1);
    });
  });

  group('toJson', () {
      test('should return a Json Map containing the proper data', () async {
          // arrange
        Map<String, dynamic> expectMap = {
          "data": {
            "version": "1.0.0",
            "appVersionSeq": 1
          }
        };
        // act
        final result = versionInfoModel.toJson();
          // assert
        expect(result, expectMap);
       });
  });
}
