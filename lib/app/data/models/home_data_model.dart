import 'package:meta/meta.dart';
import 'package:search_gold_quotes/app/domain/entities/home_data.dart';
import 'package:search_gold_quotes/app/domain/entities/home_gold.dart';
import 'gold_model.dart';

class HomeDataModel extends HomeData {
  HomeDataModel(
      {@required String famousQuotes,
      @required String referenceSiteName,
      @required List<GoldModel> goldList}): super(
    famousQuotes: famousQuotes,
    referenceSiteName: referenceSiteName,
    goldList: goldList
  );

  // List<HomeGold> toHomeGoldList(List<GoldModel> goldModelList) {
  //   List<GoldModel> _goldList = List<GoldModel>.from(goldModelList.map((item) => GoldModel.fromJSON(item)));
  //   return goldModelList.map((item) => HomeGold(date: item.date, day: null, price: item.price));
  // }

  factory HomeDataModel.fromJSON(Map<String, dynamic> jsonMap) {
    Iterable iterator = jsonMap['goldList'];
    List<GoldModel> _goldList = List<GoldModel>.from(iterator.map((item) => GoldModel.fromJSON(item)));
    return HomeDataModel(
        famousQuotes: jsonMap['famousQuotes'],
        referenceSiteName: jsonMap['referenceSiteName'],
        goldList: _goldList);
  }

  Map<String, dynamic> toJSON() {
    return {
      "famousQuotes": famousQuotes,
      "referenceSiteName": referenceSiteName,
      "goldList": (goldList as List<GoldModel>).map((item) => item.toJSON())
    };
  }
}
