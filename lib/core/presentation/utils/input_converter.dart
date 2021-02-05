import 'package:dartz/dartz.dart';
import 'package:search_gold_quotes/core/error/failures.dart';

class InputConverter {
  Either<Failure, int> stringToUnsignedInteger(String string) {
    try {
      final inputNumber = int.parse(string);
      if (inputNumber < 0) return Left(InvalidInputFailure());
      return Right(inputNumber);
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }
}

class InvalidInputFailure extends Failure {}