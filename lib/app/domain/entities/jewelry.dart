import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class Jewelry extends Equatable {
  String date;
  String price;
  String goldCurrency;

  Jewelry({@required this.date, @required this.price, @required this.goldCurrency});
}