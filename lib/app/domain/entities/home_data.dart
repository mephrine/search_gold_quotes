import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'home_gold.dart';

class HomeData extends Equatable {
  String famousQuotes;
  String famousSayingWriter;
  String referenceSiteName;
  List<HomeGold> goldList;

  HomeData({
    @required this.famousQuotes,
    @required this.famousSayingWriter,
    @required this.referenceSiteName,
    @required this.goldList
  });

  @override
  List<Object> get props => [famousQuotes, famousSayingWriter, referenceSiteName, goldList];
}