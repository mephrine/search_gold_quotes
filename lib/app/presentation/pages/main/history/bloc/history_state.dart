part of 'history_bloc.dart';

@immutable
abstract class HistoryState extends Equatable {}

class InitialHistoryState extends HistoryState {
  @override
  List<Object> get props => const <dynamic>[];
}

class Empty extends InitialHistoryState {}

class Loading extends InitialHistoryState {}

class Loaded extends InitialHistoryState {
  final HistoryJewelryList historyList;

  Loaded({@required this.historyList});
}

class Error extends InitialHistoryState {
  final String errorMessage;
  Error({@required this.errorMessage});
}
