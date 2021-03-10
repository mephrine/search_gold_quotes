import 'package:meta/meta.dart';
import 'jewelry.dart';

class HistoryJewelry extends Jewelry {
  String variation;

  HistoryJewelry({
    @required String variation,
    @required String date,
    @required String price}): super(date: date, price: price);

  @override
  List<Object> get props => [variation, date, price];
}