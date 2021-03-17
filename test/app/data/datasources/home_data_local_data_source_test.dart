import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:search_gold_quotes/app/data/datasources/home_data_local_data_source.dart';
import 'package:search_gold_quotes/app/data/models/jewelry_model.dart';
import 'package:search_gold_quotes/app/data/models/home_data_model.dart';
import 'package:search_gold_quotes/core/error/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  HomeDataLocalDataSource localDataSource;
  MockSharedPreferences sharedPreferences;
  setUp(() {
    sharedPreferences = MockSharedPreferences();
    localDataSource =
        HomeDataLocalDataSourceImpl(sharedPreferences: sharedPreferences);
  });

  group('HomeDataLocalDataSource', () {
    final goldList = [
      JewelryModel(
          jewelryType: 'G',
          goldDate: '2021-02-10',
          goldPurity: '100',
          goldPriceType: 'W',
          goldPrice: '100000',
          goldCurrency: 'C001C001'),
      JewelryModel(
          jewelryType: 'G',
          goldDate: '2021-02-09',
          goldPurity: '70',
          goldPriceType: 'W',
          goldPrice: '90000',
          goldCurrency: 'C001C001'),
      JewelryModel(
          jewelryType: 'G',
          goldDate: '2021-02-08',
          goldPurity: '100',
          goldPriceType: 'W',
          goldPrice: '95000',
          goldCurrency: 'C001C001'),
    ];
    final homeDataModel = HomeDataModel(
        famousQuotes: 'Gold is God',
        famousSayingWriter: 'aaa',
        referenceSiteName: 'https://www.naver.com',
        goldList: goldList);
    test('should get last home data when cache is exist', () async {
      // arrange
      when(sharedPreferences.getString(any))
          .thenReturn(fixture('home_data.json'));
      // act
      final result = await localDataSource.getLastHomeData();

      // assert
      expect(result, homeDataModel);
    });

    test('should return CacheException when cache is empty', () async {
      // arrange
      when(sharedPreferences.getString(any)).thenReturn(null);
      // act
      final call = localDataSource.getLastHomeData;
      // assert
      expect(() => call(), throwsA(isInstanceOf<CacheException>()));
    });
  });
}
