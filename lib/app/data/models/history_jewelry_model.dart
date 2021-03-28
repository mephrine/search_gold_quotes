import 'package:search_gold_quotes/app/domain/entities/history_jewelry.dart';
import 'package:meta/meta.dart';

class HistoryJewelryListModel extends HistoryJewelryList {
  HistoryJewelryListModel({@required List<HistoryJewelryModel> historyList})
      : super(historyList: historyList);

  factory HistoryJewelryListModel.fromJson(Map<String, dynamic> jsonMap) {
    try {
      Iterable iterator = jsonMap['data'];
      final _historyList = List<HistoryJewelryModel>.from(
          iterator.map((item) => HistoryJewelryModel.fromJson(item)));
      return HistoryJewelryListModel(historyList: _historyList);
    } catch (excepiton) {}
    return HistoryJewelryListModel.empty();
  }

  factory HistoryJewelryListModel.empty() {
    return HistoryJewelryListModel(historyList: []);
  }
}

class HistoryJewelryModel extends HistoryJewelry {
  final String jewelryType;
  final String goldPurity;
  final String goldPriceType;

  HistoryJewelryModel(
      {@required this.jewelryType,
      @required String goldDate,
      @required this.goldPurity,
      @required this.goldPriceType,
      @required String goldCurrency,
      @required String goldPrice})
      : super(date: goldDate, price: goldPrice, goldCurrency: goldCurrency);

  @override
  List<Object> get props =>
      [jewelryType, date, goldPurity, goldPriceType, price, goldCurrency];

  factory HistoryJewelryModel.fromJson(Map<String, dynamic> jsonMap) {
    return HistoryJewelryModel(
        jewelryType: jsonMap['jewelryType'],
        goldDate: jsonMap['goldDate'],
        goldPurity: jsonMap['goldPurity'],
        goldPriceType: jsonMap['goldPriceType'],
        goldPrice: jsonMap['avgGoldPrice'],
        goldCurrency: jsonMap['goldCurrency']);
  }

  Map<String, dynamic> toJson() {
    return {
      "jewelryType": jewelryType,
      "goldDate": date,
      "goldPurity": goldPurity,
      "goldPriceType": goldPriceType,
      "goldPrice": price,
      "goldCurrency": goldCurrency
    };
  }
}
