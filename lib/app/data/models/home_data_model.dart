import 'package:meta/meta.dart';
import 'package:search_gold_quotes/app/domain/entities/home_data.dart';

import 'jewelry_model.dart';

class HomeDataModel extends HomeData {
  HomeDataModel(
      {@required List<JewelryModel> goldList,
      @required FamousSayingDomain famousSayingData})
      : super(famousSayingData: famousSayingData, goldList: goldList);

  // List<HomeGold> toHomeGoldList(List<JewelryModel> JewelryModelList) {
  //   List<JewelryModel> _goldList = List<JewelryModel>.from(JewelryModelList.map((item) => JewelryModel.fromJson(item)));
  //   return JewelryModelList.map((item) => HomeGold(date: item.date, day: null, price: item.price));
  // }

  // factory HomeDataModel.fromJson(Map<String, dynamic> json) =>
  //     _$HomeDataModelFromJson(json);
  //
  // Map<String, dynamic> toJson() => _$HomeDataModelToJson(this);

  factory HomeDataModel.fromJson(Map<String, dynamic> jsonMap) {
    try {
      final Map<String, dynamic> data = jsonMap['data'];
      Iterable iterator = data['goldPriceDomain'];
      List<JewelryModel> _goldList = List<JewelryModel>.from(
          iterator.map((item) => JewelryModel.fromJson(item)));
      return HomeDataModel(
          famousSayingData:
              FamousSayingDomain.fromJson(data['famousSayingDomain']),
          goldList: _goldList);
    } catch (e) {
      return HomeDataModel.empty();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "data": {
        "famousSayingDomain": (famousSayingData as FamousSayingDomain).toJson(),
        "goldList":
            (goldList as List<JewelryModel>).map((item) => item.toJson())
      }
    };
  }

  factory HomeDataModel.empty() {
    return HomeDataModel(famousSayingData: null, goldList: []);
  }
}

class FamousSayingDomain extends FamousSayingData {
  FamousSayingDomain({
    @required String famousSaying,
    @required String famousSayingWriter,
    @required String referenceSiteName,
  }) : super(
            famousSaying: famousSaying,
            famousSayingWriter: famousSayingWriter,
            referenceSiteName: referenceSiteName);

  factory FamousSayingDomain.fromJson(Map<String, dynamic> jsonMap) {
    try {
      return FamousSayingDomain(
        famousSaying: jsonMap['famousSaying'],
        famousSayingWriter: jsonMap['famousSayingWriter'],
        referenceSiteName: jsonMap['referenceSiteName'],
      );
    } catch (e) {
      return FamousSayingDomain.empty();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "famousSaying": famousSaying,
      "famousSayingWriter": famousSayingWriter,
      "referenceSiteName": referenceSiteName
    };
  }

  factory FamousSayingDomain.empty() => FamousSayingDomain(
      famousSaying: "", famousSayingWriter: "", referenceSiteName: "");
}
