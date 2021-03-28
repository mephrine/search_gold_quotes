import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'jewelry.dart';

class HistoryJewelryList extends Equatable {
  final List<HistoryJewelry> historyList;
  HistoryJewelryList({@required this.historyList});

  @override
  List<Object> get props => historyList;
}

class HistoryJewelry extends Jewelry {
  HistoryJewelry(
      {@required String date,
      @required String price,
      @required String goldCurrency})
      : super(date: date, price: price, goldCurrency: goldCurrency);

  @override
  List<Object> get props => [date, price, goldCurrency];
}
