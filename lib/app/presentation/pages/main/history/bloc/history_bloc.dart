import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:search_gold_quotes/app/domain/entities/history_jewelry.dart';
import 'package:search_gold_quotes/app/domain/usecases/get_searched_price_history.dart';
import 'package:search_gold_quotes/core/error/failures.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final GetSearchedPriceHistory useCase;

  HistoryBloc({@required GetSearchedPriceHistory getHistoryUseCase})
      : assert(getHistoryUseCase != null),
        useCase = getHistoryUseCase,
        super(Empty());

  @override
  HistoryState get initialState => Empty();

  @override
  Stream<HistoryState> mapEventToState(HistoryEvent event) async* {
    if (event is GetSearchedHistoryList) {
      yield Loading();
      final failureOrHistoryList = await useCase(Params(
          jewelryType: event.jewelryType,
          period: event.period,
          exchangeState: event.exchangeState));
      yield failureOrHistoryList.fold(
          (failure) => Error(errorMessage: failureToErrorMessage(failure)),
          (result) => Loaded(
              period: event.period,
              exchangeState: event.exchangeState,
              historyList: result));
    }
  }

  String failureToErrorMessage(Failure failure) {
    return '일시적인 오류가 발생했습니다. 다시 시도해주세요.';
  }
}
