import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:search_gold_quotes/app/domain/usecases/get_version_info.dart';

import 'bloc.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final GetVersionInfo getVersionInfo;

  SplashBloc({@required GetVersionInfo versionInfo})
      : assert(null != versionInfo),
        getVersionInfo = versionInfo,
        super(Empty());

  @override
  SplashState get initialState => Empty();

  @override
  Stream<SplashState> mapEventToState(
    SplashEvent event,
  ) async* {
      if (event is GetVersionInfoForUpdate) {
      }
  }
}
