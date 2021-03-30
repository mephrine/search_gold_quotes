import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'home_gold.dart';

class HomeData extends Equatable {
  final List<HomeGold> goldList;
  final FamousSayingData famousSayingData;

  HomeData({@required this.famousSayingData, @required this.goldList});

  @override
  List<Object> get props => [famousSayingData, goldList];
}

class FamousSayingData extends Equatable {
  final String famousSaying;
  final String famousSayingWriter;
  final String referenceSiteName;

  FamousSayingData(
      {@required this.famousSaying,
      @required this.famousSayingWriter,
      @required this.referenceSiteName});

  @override
  List<Object> get props =>
      [famousSaying, famousSayingWriter, referenceSiteName];
}
