part of 'home_bloc.dart';

@immutable
abstract class HomeState extends Equatable {}

class InitialHomeState extends HomeState {
  @override
  List<Object> get props => const <dynamic>[];
}

class Empty extends InitialHomeState {}

class Loading extends InitialHomeState {}

class Loaded extends InitialHomeState {
  final HomeData homeData;
  final List<double> sortedPriceList;

  Loaded({@required this.homeData, @required this.sortedPriceList});
}

class Error extends InitialHomeState {
  final String message;

  Error({@required this.message});
}
