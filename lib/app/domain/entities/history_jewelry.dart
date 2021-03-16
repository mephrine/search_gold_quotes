import 'package:meta/meta.dart';
import 'jewelry.dart';

class HistoryJewelry extends Jewelry {
  final String variation;

  HistoryJewelry(
      {@required this.variation,
      @required String date,
      @required String price,
      @required String goldCurrency})
      : super(date: date, price: price, goldCurrency: goldCurrency);

  @override
  List<Object> get props => [variation, date, price];
}
