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

  Loaded({
    @required this.homeData
  });
}

class Error extends InitialHomeState {

}