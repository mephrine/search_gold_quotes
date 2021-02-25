import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'history_event.dart';

part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final GetHomeData getHomeData;

  HistoryBloc({
    @required GetHomeData homeData
  }): assert(null != homeData),
  getHomeData = homeData,
  super(Empty());

  @override
  HistoryState get initialState => Empty();

  @override
  Stream<HistoryState> mapEventToState(HistoryEvent event) async* {
    if (event is GetHomeData) {

    }
  }
}
