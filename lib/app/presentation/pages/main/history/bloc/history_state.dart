part of 'history_bloc.dart';

@immutable
abstract class HistoryState extends Equatable {}

class InitialHistoryState extends HistoryState {
  @override
  List<Object> get props => const <dynamic>[];
}

class Empty extends InitialHistoryState {}

class Loading extends InitialHistoryState {}

class Loaded extends InitialHistoryState {
  final Period period;
  final ExchangeState exchangeState;
  final HistoryJewelryList historyList;
  final double maxPrice;
  final double middlePrice;
  final double minPrice;

  Loaded(
      {@required this.period,
      @required this.exchangeState,
      @required this.historyList,
      @required this.maxPrice,
      @required this.middlePrice,
      @required this.minPrice});
}

class Error extends InitialHistoryState {
  final String errorMessage;
  Error({@required this.errorMessage});
}
