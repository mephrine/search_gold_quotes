part of 'home_bloc.dart';

@immutable
abstract class HomeState extends Equatable {}

class InitialHomeState extends HomeState {
  @override
  // TODO: implement props
  List<Object> get props => const <dynamic>[];

}

class Empty extends InitialHomeState {}

class Loading extends InitialHomeState {}

class Loaded extends InitialHomeState {

}

class Error extends InitialHomeState {

}