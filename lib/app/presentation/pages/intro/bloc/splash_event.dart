import 'package:meta/meta.dart';

@immutable
abstract class SplashEvent {}

class GetVersionInfoForUpdate extends SplashEvent {}
