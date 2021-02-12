import 'package:meta/meta.dart';
import 'package:search_gold_quotes/app/domain/entities/jewelry.dart';

class GoldModel extends Jewelry {
  final String jewelryType;
  final String goldPurity;
  final String goldPriceType;

  GoldModel({
    @required this.jewelryType,
    @required String goldDate,
    @required this.goldPurity,
    @required this.goldPriceType,
    @required String goldPrice}): super(date: goldDate, price: goldPrice);

  @override
  List<Object> get props => null;
}