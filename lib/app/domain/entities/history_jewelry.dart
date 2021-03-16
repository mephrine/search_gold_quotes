import 'package:meta/meta.dart';
import 'jewelry.dart';

class HistoryJewelry extends Jewelry {
  final String variationState;
  final String variationPrice;

  HistoryJewelry(
      {@required this.variationState,
      @required this.variationPrice,
      @required String date,
      @required String price,
      @required String goldCurrency})
      : super(date: date, price: price, goldCurrency: goldCurrency);

  @override
  List<Object> get props =>
      [variationState, variationPrice, date, price, goldCurrency];
}
