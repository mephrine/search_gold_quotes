import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'history_event.dart';

part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc(HistoryState initialState) : super(initialState);

  @override
  HistoryState get initialState => Empty();

  @override
  Stream<HistoryState> mapEventToState(HistoryEvent event) async* {
  }
}
