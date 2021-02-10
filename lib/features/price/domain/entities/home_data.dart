import 'package:equatable/equatable.dart';
import 'gold.dart';

class HomeData extends Equatable {
  String famousQuotes;
  String referenceSiteName;
  List<Gold> goldList;

  @override
  List<Object> get props => [famousQuotes, referenceSiteName, goldList];
}