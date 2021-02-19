import 'package:meta/meta.dart';
import 'package:search_gold_quotes/app/domain/entities/version_info.dart';

@immutable
abstract class SplashState {}

class SplashInitial extends SplashState {}

class Empty extends SplashInitial {}

class Loading extends SplashInitial {}

class Loaded extends SplashInitial {
  final VersionInfo versionInfo;

  Loaded({
   @required this.versionInfo
  });
}

class Error extends SplashInitial {
  final String message;

  Error({
    @required this.message
  });
}

