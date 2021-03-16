import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class Jewelry extends Equatable {
  final String date;
  final String price;
  final String goldCurrency;

  Jewelry(
      {@required this.date, @required this.price, @required this.goldCurrency});
}
