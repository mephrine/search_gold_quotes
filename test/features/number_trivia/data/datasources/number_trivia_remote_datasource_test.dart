import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:search_gold_quotes/core/error/exceptions.dart';
import 'package:search_gold_quotes/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:search_gold_quotes/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:search_gold_quotes/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixture_reader.dart';


class MockHttpClient extends Mock implements Client {}

void main() {
  NumberTriviaRemoteDataSourceImpl dataSource;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = NumberTriviaRemoteDataSourceImpl(httpClient: mockHttpClient);
  });

  void setUpMockHttpClientSuccess200() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => Response(fixture('trivia.json'), 200));
  }

  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => Response("Server Exception Message", 404));
  }

  group('GetConcreteNumberTrivia', () {
    final testNumber = 1;
    final numberTriviaModel = NumberTriviaModel(text: "Test Text", number: 1);

    test('''should perform a GET request on a URL with number
    being the endpoint and with application/json header''',
            () {
          // arrange
              setUpMockHttpClientSuccess200();
          // act
          dataSource.getConcreteNumberTrivia(testNumber);
          // assert
          verify(mockHttpClient.get('http://numbersapi.com/$testNumber?json', headers: {'Content-Type': 'application/json'}));
        });

    test('should return NumberTrivia when the reponse code is 200 (success)',
            () async {
          // arrange
              setUpMockHttpClientSuccess200();
          // act
          final result = await dataSource.getConcreteNumberTrivia(testNumber);
          // assert
          expect(result, equals(numberTriviaModel));
        });

    test('should throw a ServerException when the response code is 404 or other',
            () async {
          // arrange
              setUpMockHttpClientFailure404();
          // act
          final call = dataSource.getConcreteNumberTrivia;
          // assert
          expect(() => call(testNumber), throwsA(isInstanceOf<ServerException>()));
        });
  });

  group('GetRandomNumberTrivia', () {
    final numberTriviaModel = NumberTriviaModel(text: "Test Text", number: 1);

    test('''should perform a GET request on a URL with number
    being the endpoint and with application/json header''',
            () {
          // arrange
          setUpMockHttpClientSuccess200();
          // act
          dataSource.getRandomNumberTrivia();
          // assert
          verify(mockHttpClient.get('http://numbersapi.com/random/trivia?json', headers: {'Content-Type': 'application/json'}));
        });

    test('should return NumberTrivia when the response code is 200 (success)',
            () async {
          // arrange
          setUpMockHttpClientSuccess200();
          // act
          final result = await dataSource.getRandomNumberTrivia();
          // assert
          expect(result, equals(numberTriviaModel));
        });

    test('should throw a ServerException when the response code is 404 or other',
            () async {
          // arrange
          setUpMockHttpClientFailure404();
          // act
          final call = dataSource.getRandomNumberTrivia;
          // assert
          expect(() => call(), throwsA(isInstanceOf<ServerException>()));
        });
  });
}