import 'dart:async';

import 'package:bloc/bloc.dart';

import 'bloc.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {

  SplashBloc() : super(null);

  @override
  SplashState get initialState => SplashInitial();

  @override
  Stream<SplashState> mapEventToState(
    SplashEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }


}
