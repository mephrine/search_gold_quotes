import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SplashState extends Equatable {}

class SplashInitial extends SplashState {
  @override
  List<Object> get props => const <dynamic>[];
}

class Empty extends SplashInitial {}

class Loading extends SplashInitial {}

class Loaded extends SplashInitial {
  final bool needsForceUpdate;
  final String updateMessage;

  Loaded({@required this.needsForceUpdate, @required this.updateMessage});
}

class Error extends SplashInitial {
  final String message;

  Error({@required this.message});
}
