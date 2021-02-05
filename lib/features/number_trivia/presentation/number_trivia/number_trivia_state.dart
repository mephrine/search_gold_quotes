part of 'number_trivia_bloc.dart';


@immutable
abstract class NumberTriviaState {}

class InitialNumberTriviaState extends NumberTriviaState {}

class Empty extends InitialNumberTriviaState {}

class Loading extends InitialNumberTriviaState {}

class Loaded extends InitialNumberTriviaState {
  final NumberTrivia trivia;

  Loaded({@required this.trivia});
}

class Error extends InitialNumberTriviaState {
  final String message;

  Error({@required this.message});
}
