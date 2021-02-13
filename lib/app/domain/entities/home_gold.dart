import 'package:meta/meta.dart';

import 'jewelry.dart';

class HomeGold extends Jewelry {
  String day;

  HomeGold({
    @required String date,
    @required String day,
    @required String price}): super(date: date, price: price);

  @override
  List<Object> get props => [date, day, price];
}