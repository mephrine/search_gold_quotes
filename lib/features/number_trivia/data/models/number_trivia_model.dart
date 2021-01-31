import 'package:flutter/foundation.dart';
import 'package:search_gold_quotes/features/number_trivia/domain/entities/number_trivia.dart';

class NumberTriviaModel extends NumberTrivia {
  NumberTriviaModel({
    @required int number,
    @required String text
  }): super(number: number, text: text);
}