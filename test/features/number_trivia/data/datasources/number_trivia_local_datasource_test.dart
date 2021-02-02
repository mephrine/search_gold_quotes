import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:search_gold_quotes/core/error/exceptions.dart';
import 'package:search_gold_quotes/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:search_gold_quotes/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  NumberTriviaLocalDataSourceImpl dataSource;
  MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = NumberTriviaLocalDataSourceImpl(preferences: mockSharedPreferences);
  });

  group('getLastNumberTrivia', () {
    final testNumberTriviaModel = NumberTriviaModel.fromJson(json.decode(fixture('trivia_cached.json')));
    test('should return number trivia from SharedPreferences when there is one in the cache', () async {
        // arrange
        when(mockSharedPreferences.getString(any))
            .thenReturn(fixture('trivia_cached.json'));
        // act
        final result = await dataSource.getLastNumberTrivia();
        // assert
        verify(mockSharedPreferences.getString('CACHED_NUMBER_TRIVIA'));
        expect(result, equals(testNumberTriviaModel));
     });

    test('should throw a CacheException when there is not a cached value', () async {
      // arrange
      when(mockSharedPreferences.getString(any))
          .thenReturn(null);
      // act
      final call = dataSource.getLastNumberTrivia;
      // assert
      expect(() => call(), throwsA(isInstanceOf<CacheException>()));
    });
  });
}