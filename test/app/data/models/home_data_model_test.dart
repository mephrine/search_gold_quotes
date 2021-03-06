import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:search_gold_quotes/app/data/models/gold_model.dart';
import 'package:search_gold_quotes/app/data/models/home_data_model.dart';
import 'package:search_gold_quotes/app/domain/entities/home_data.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  HomeDataModel homeDataModel;
  setUp(() {
    final goldList = [
      GoldModel(jewelryType: 'G', goldDate: '2021-02-10', goldPurity: '100', goldPriceType: 'W', goldPrice: '100000'),
      GoldModel(jewelryType: 'G', goldDate: '2021-02-09', goldPurity: '70', goldPriceType: 'W', goldPrice: '90000'),
      GoldModel(jewelryType: 'G', goldDate: '2021-02-08', goldPurity: '100', goldPriceType: 'W', goldPrice: '95000'),
    ];
    homeDataModel = HomeDataModel(famousQuotes: 'Gold is God', famousSayingWriter: 'aaa', referenceSiteName: 'https://www.naver.com', goldList: goldList);
  });

  test('should is subclass', () async {
    // assert
    expect(homeDataModel, isA<HomeData>());
   });


  group('from JSON', () {
    test('should return a valid model when the JSON goldList is a List', () async {
      // arrange
      final Map<String, dynamic> jsonMap = json.decode(fixture('home_data.json'));
      // act
      final result = HomeDataModel.fromJson(jsonMap);
      // assert
      expect(result, homeDataModel);
    });
  });

  group('to JSON', () {
      test('should when', () async {
          // arrange
        final Map<String, dynamic> jsonMap = {
          "famous_saying": "Gold is God",
          "famous_saying_writer": "aaa",
          "referenceSiteName": "https://www.naver.com",
          "goldList": [
            {
              "jewelryType": "G",
              "goldDate": "2021-02-10",
              "goldPurity": "100",
              "goldPriceType": "W",
              "goldPrice": "100000"
            } ,
            {
              "jewelryType": "G",
              "goldDate": "2021-02-09",
              "goldPurity": "70",
              "goldPriceType": "W",
              "goldPrice": "90000"
            } ,
            {
              "jewelryType": "G",
              "goldDate": "2021-02-08",
              "goldPurity": "100",
              "goldPriceType": "W",
              "goldPrice": "95000"
            }
          ]
        };
          // act
        final result = homeDataModel.toJson();
          // assert
        expect(result, jsonMap);
       });
  });
}