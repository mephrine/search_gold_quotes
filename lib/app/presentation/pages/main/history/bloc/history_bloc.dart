import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:search_gold_quotes/app/domain/entities/history_jewelry.dart';
import 'package:search_gold_quotes/app/domain/usecases/get_searched_price_history.dart';
import 'package:search_gold_quotes/core/error/error_messages.dart';
import 'package:search_gold_quotes/core/error/failures.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final GetSearchedPriceHistory useCase;

  HistoryBloc({@required GetSearchedPriceHistory getHistoryUseCase})
      : assert(getHistoryUseCase != null),
        useCase = getHistoryUseCase,
        super(Empty());

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
              historyList: result,
              chartList: chartList(result),
              sortedPriceList: chartPriceList(result)));
    } else if (event is RefreshSearchedHistoryList) {
      final failureOrHistoryList = await useCase(Params(
          jewelryType: event.jewelryType,
          period: event.period,
          exchangeState: event.exchangeState));
      yield failureOrHistoryList.fold(
          (failure) => Error(errorMessage: failureToErrorMessage(failure)),
          (result) => Loaded(
              period: event.period,
              exchangeState: event.exchangeState,
              historyList: result,
              chartList: chartList(result),
              sortedPriceList: chartPriceList(result)));
    }
  }

  List<HistoryJewelry> chartList(HistoryJewelryList historyList) =>
      historyList.historyList
          .getRange(0, min(5, historyList.historyList.length))
          .toList();

  List<double> chartPriceList(HistoryJewelryList historyList) =>
      chartList(historyList).map((item) => double.tryParse(item.price)).toList()
        ..sort();

  // double getMaxPrice(HistoryJewelryList historyList) => chartList(historyList)
  //     .map((item) => double.tryParse(item.price) ?? 0)
  //     .reduce((current, next) => current > next ? current : next);

  // double getMinPrice(HistoryJewelryList historyList) => chartList(historyList)
  //     .map((item) => double.tryParse(item.price) ?? 0)
  //     .reduce((current, next) => current < next ? current : next);

  // double getMiddlePrice(HistoryJewelryList historyList) {
  //   final minPrice = getMinPrice(historyList);
  //   final maxPrice = getMaxPrice(historyList);
  //   return minPrice + (maxPrice - minPrice) ~/ 2.0;
  // }

  String failureToErrorMessage(Failure failure) {
    if (failure is ServerFailure) {
      return SERVER_FAILURE_MESSAGE;
    }
    return PARSE_FAILURE_MESSAGE;
  }
}
