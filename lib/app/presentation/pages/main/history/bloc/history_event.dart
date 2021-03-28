part of 'history_bloc.dart';

@immutable
abstract class HistoryEvent {}

class GetSearchedHistoryList extends HistoryEvent {
  final Period period;
  final ExchangeState exchangeState;
  final JewelryType jewelryType;

  GetSearchedHistoryList(
      {@required this.period,
      @required this.exchangeState,
      @required this.jewelryType});
}
