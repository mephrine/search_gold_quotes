import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:search_gold_quotes/app/domain/entities/home_data.dart';

import 'gold_model.dart';

class HomeDataModel extends HomeData {
  HomeDataModel(
      {@required String famousQuotes,
      @required String famousSayingWriter,
      @required String referenceSiteName,
      @required List<GoldModel> goldList})
      : super(
            famousQuotes: famousQuotes,
            famousSayingWriter: famousSayingWriter,
            referenceSiteName: referenceSiteName,
            goldList: goldList);

  // List<HomeGold> toHomeGoldList(List<GoldModel> goldModelList) {
  //   List<GoldModel> _goldList = List<GoldModel>.from(goldModelList.map((item) => GoldModel.fromJson(item)));
  //   return goldModelList.map((item) => HomeGold(date: item.date, day: null, price: item.price));
  // }

  // factory HomeDataModel.fromJson(Map<String, dynamic> json) =>
  //     _$HomeDataModelFromJson(json);
  //
  // Map<String, dynamic> toJson() => _$HomeDataModelToJson(this);

  factory HomeDataModel.fromJson(Map<String, dynamic> jsonMap) {
    try {
      final Map<String, dynamic> data = jsonMap['data'];
      Iterable iterator = data['goldList'];
      List<GoldModel> _goldList = List<GoldModel>.from(iterator.map((item) => GoldModel.fromJson(item)));
      return HomeDataModel(
          famousQuotes: data['famousSaying'],
          famousSayingWriter: data['famousSayingWriter'],
          referenceSiteName: data['referenceSiteName'],
          goldList: _goldList);
    } catch(e) {
      return HomeDataModel.empty();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "data": {
        "famousSaying": famousQuotes,
        "famousSayingWriter": famousSayingWriter,
        "referenceSiteName": referenceSiteName,
        "goldList": (goldList as List<GoldModel>).map((item) => item.toJson())
      }
    };
  }

  factory HomeDataModel.empty() {
    return HomeDataModel(
        famousQuotes: "",
        famousSayingWriter: '',
        referenceSiteName: "",
        goldList: []);
  }
}
