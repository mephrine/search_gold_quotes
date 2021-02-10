import 'package:equatable/equatable.dart';

import 'jewelry.dart';

class Gold extends Jewelry {
  @override
  List<Object> get props => [date, day, price];
}