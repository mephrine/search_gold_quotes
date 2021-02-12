import 'package:meta/meta.dart';
import 'package:search_gold_quotes/app/domain/entities/home_data.dart';
import 'gold_model.dart';

class PriceModel extends HomeData {

  PriceModel({
    @required String famousQuotes,
    @required String referenceSiteName,
    @required List<GoldModel> goldList
  });
}