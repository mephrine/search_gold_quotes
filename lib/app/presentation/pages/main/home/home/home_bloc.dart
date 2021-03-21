import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:search_gold_quotes/app/domain/entities/home_data.dart';
import 'package:search_gold_quotes/app/domain/usecases/get_home_data.dart';
import 'package:search_gold_quotes/core/error/error_messages.dart';
import 'package:search_gold_quotes/core/error/failures.dart';
import 'package:search_gold_quotes/core/usecases/no_params.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetHomeInfo getHomeInfo;

  HomeBloc({@required GetHomeInfo homeInfo})
      : assert(null != homeInfo),
        getHomeInfo = homeInfo,
        super(Empty());

  @override
  HomeState get initialState => Empty();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is GetHomeData) {
      yield Loading();
      final homeInfo = await getHomeInfo(NoParams());
      yield homeInfo.fold(
          (failure) => Error(message: failureToErrorMessage(failure)),
          (homeInfo) => Loaded(homeData: homeInfo));
    }
  }

  String failureToErrorMessage(Failure failure) {
    if (failure is ServerFailure) {
      return SERVER_FAILURE_MESSAGE;
    }
    return PARSE_FAILURE_MESSAGE;
  }
}
