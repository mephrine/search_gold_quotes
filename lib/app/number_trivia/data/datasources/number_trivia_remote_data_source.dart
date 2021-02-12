import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:search_gold_quotes/core/error/exceptions.dart';
import 'package:search_gold_quotes/app/number_trivia/data/models/number_trivia_model.dart';

abstract class NumberTriviaRemoteDataSource {
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);
  Future<NumberTriviaModel> getRandomNumberTrivia();
}

class NumberTriviaRemoteDataSourceImpl implements NumberTriviaRemoteDataSource {
  Client httpClient;


  NumberTriviaRemoteDataSourceImpl({@required this.httpClient});

  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number)
    => _getTriviaFromUrl('http://numbersapi.com/$number?json');
  

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia()
    => _getTriviaFromUrl('http://numbersapi.com/random/trivia?json');


  Future<NumberTriviaModel> _getTriviaFromUrl(String url) async {
    final response = await httpClient.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return NumberTriviaModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}