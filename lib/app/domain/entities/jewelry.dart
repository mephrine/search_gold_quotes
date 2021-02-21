import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class Jewelry extends Equatable {
  String date;
  String price;

  Jewelry({@required this.date, @required this.price});
}