import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:search_gold_quotes/app/data/models/version_info_model.dart';
import 'package:search_gold_quotes/app/domain/entities/version_info.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  VersionInfoModel versionInfoModel;
  setUp(() {
    versionInfoModel =
        VersionInfoModel(latestVersion: "1.0.0", forceUpdate: "Y");
  });

  test('should be a subclass of a VersionInfo', () async {
    expect(versionInfoModel, isA<VersionInfo>());
  });

  group('fromJSON', () {
    test('should return a valid model json forceUpdate is string', () async {
      // arrange
      final jsonMap = json.decode(fixture('version_info.json'));
      // act
      final result = VersionInfoModel.fromJson(jsonMap);
      // assert
      expect(result, versionInfoModel);
    });
  });

  group('toJSON', () {
      test('should return a Json Map containing the proper data', () async {
          // arrange
        Map<String, dynamic> expectMap = {
          "latestVersion": "1.0.0",
          "forceUpdate": "Y"
        };
        // act
        final result = versionInfoModel.toJson();
          // assert
        expect(result, expectMap);
       });
  });
}
