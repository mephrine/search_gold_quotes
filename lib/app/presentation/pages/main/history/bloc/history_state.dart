part of 'history_bloc.dart';

@immutable
abstract class HistoryState extends Equatable {}

class InitialHistoryState extends HistoryState {
  @override
  // TODO: implement props
  List<Object> get props => const <dynamic>[];

}

class Empty extends InitialHistoryState {}

class Loading extends InitialHistoryState {}

class Loaded extends InitialHistoryState {

}

class Error extends InitialHistoryState {

}