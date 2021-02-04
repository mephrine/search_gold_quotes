import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:search_gold_quotes/features/number_trivia/data/models/number_trivia_model.dart';

abstract class NumberTriviaRemoteDataSource {
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);
  Future<NumberTriviaModel> getRandomNumberTrivia();
}

class NumberTriviaRemoteDataSourceImpl implements NumberTriviaRemoteDataSource {
  Client httpClient;


  NumberTriviaRemoteDataSourceImpl({@required this.httpClient});

  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) {
    return null;
  }

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() {
    return null;
  }

}