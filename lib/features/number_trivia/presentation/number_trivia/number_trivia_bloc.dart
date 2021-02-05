import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'number_trivia_event.dart';

part 'number_trivia_state.dart';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  NumberTriviaBloc(NumberTriviaState initialState) : super(initialState);

  @override
  NumberTriviaState get initialState => InitialNumberTriviaState();

  @override
  Stream<NumberTriviaState> mapEventToState(NumberTriviaEvent event) async* {
    // TODO: Add your event logic
  }
}
