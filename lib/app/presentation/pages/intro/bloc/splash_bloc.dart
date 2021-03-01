import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:search_gold_quotes/app/domain/usecases/get_version_info.dart';
import 'package:search_gold_quotes/core/usecases/NoParams.dart';

import 'bloc.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';

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
      yield Loading();
      final failOrVersionInfo = await getVersionInfo(NoParams());
      yield failOrVersionInfo.fold((failure)
          => Error(message: SERVER_FAILURE_MESSAGE)
      ,(versionInfo)
          => Loaded(versionInfo: versionInfo)
      );
    }
  }
}
