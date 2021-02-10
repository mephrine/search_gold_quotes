import 'package:equatable/equatable.dart';
import 'gold.dart';
import 'package:meta/meta.dart';

class HomeData extends Equatable {
  String famousQuotes;
  String referenceSiteName;
  List<Gold> goldList;

  HomeData({
    @required this.famousQuotes,
    @required this.referenceSiteName,
    @required this.goldList
  });

  @override
  List<Object> get props => [famousQuotes, referenceSiteName, goldList];
}