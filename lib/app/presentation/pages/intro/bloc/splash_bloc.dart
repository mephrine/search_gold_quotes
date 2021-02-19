import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'bloc.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final GetVersionInfoForUpdate getVersionInfoForUpdate;

  SplashBloc({@required GetVersionInfoForUpdate getVersionInfo})
      : assert(null != getVersionInfo),
        getVersionInfoForUpdate = getVersionInfo,
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
