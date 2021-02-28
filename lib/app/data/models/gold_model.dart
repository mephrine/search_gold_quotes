import 'package:meta/meta.dart';
import 'package:search_gold_quotes/app/domain/entities/home_gold.dart';

class GoldModel extends HomeGold {
  final String jewelryType;
  final String goldPurity;
  final String goldPriceType;
  final String day;

  GoldModel({
    @required this.jewelryType,
      @required String goldDate,
      @required this.goldPurity,
      @required this.goldPriceType,
      @required String goldPrice}):
        day = _dateToDay(goldDate)
       , super(date: goldDate, price: goldPrice);

  @override
  List<Object> get props => [jewelryType, date, goldPurity, goldPriceType, price];

  static String _dateToDay(String date) {
    if (date == '2021-02-10') {
      return '오늘';
    }
    return '과거';
  }

  factory GoldModel.fromJson(Map<String, dynamic> jsonMap) {
    return GoldModel(
        jewelryType: jsonMap['jewelryType'],
        goldDate: jsonMap['goldDate'],
        goldPurity: jsonMap['goldPurity'],
        goldPriceType: jsonMap['goldPriceType'],
        goldPrice: jsonMap['goldPrice']);
  }

  Map<String, dynamic> toJson() {
    return {
      "jewelryType": jewelryType,
      "goldDate": date,
      "goldPurity": goldPurity,
      "goldPriceType": goldPriceType,
      "goldPrice": price
    };
  }
}
