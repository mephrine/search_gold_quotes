import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'jewelry.dart';

class Gold extends Jewelry {
  String date;
  String day;
  String price;


  Gold({
    @required this.date,
    @required this.day,
    @required this.price});

  @override
  List<Object> get props => [date, day, price];
}