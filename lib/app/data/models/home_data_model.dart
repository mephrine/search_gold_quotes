import 'package:meta/meta.dart';
import 'package:search_gold_quotes/app/domain/entities/home_data.dart';

import 'gold_model.dart';

class HomeDataModel extends HomeData {
  HomeDataModel({
    @required String famousQuotes,
    @required String famousSayingWriter,
      @required String referenceSiteName,
      @required List<GoldModel> goldList}): super(
    famousQuotes: famousQuotes,
      famousSayingWriter: famousSayingWriter,
    referenceSiteName: referenceSiteName,
    goldList: goldList
  );

  // List<HomeGold> toHomeGoldList(List<GoldModel> goldModelList) {
  //   List<GoldModel> _goldList = List<GoldModel>.from(goldModelList.map((item) => GoldModel.fromJson(item)));
  //   return goldModelList.map((item) => HomeGold(date: item.date, day: null, price: item.price));
  // }

  factory HomeDataModel.fromJson(Map<String, dynamic> jsonMap) {
    Iterable iterator = jsonMap['goldList'];
    List<GoldModel> _goldList = List<GoldModel>.from(iterator.map((item) => GoldModel.fromJson(item)));
    return HomeDataModel(
        famousQuotes: jsonMap['famous_saying'],
        famousSayingWriter: jsonMap['famous_saying_writer'],
        referenceSiteName: jsonMap['referenceSiteName'],
        goldList: _goldList);
  }

  Map<String, dynamic> toJson() {
    return {
      "famous_saying": famousQuotes,
      "famous_saying_writer": famousSayingWriter,
      "referenceSiteName": referenceSiteName,
      "goldList": (goldList as List<GoldModel>).map((item) => item.toJson())
    };
  }
}
