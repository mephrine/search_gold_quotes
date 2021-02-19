import 'package:meta/meta.dart';
import 'package:search_gold_quotes/app/domain/usecases/get_version_info.dart';

@immutable
abstract class SplashEvent {}

class GetVersionInfoForUpdate extends SplashEvent {
}
