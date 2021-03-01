import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:search_gold_quotes/app/domain/entities/home_data.dart';
import 'package:search_gold_quotes/app/domain/usecases/get_home_data.dart';
import 'package:search_gold_quotes/app/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:search_gold_quotes/app/presentation/pages/main/history/bloc/history_bloc.dart';
import 'package:search_gold_quotes/core/usecases/NoParams.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetHomeInfo getHomeInfo;

  HomeBloc({
    @required GetHomeInfo homeInfo
  }): assert(null != homeInfo),
        getHomeInfo = homeInfo,
        super(Empty());

  @override
  HomeState get initialState => Empty();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is GetHomeData) {
      yield Loading();
      final homeInfo = await getHomeInfo(NoParams());
      yield homeInfo.fold((failure) => null, (homeInfo) => Loaded(homeData: homeInfo));
    }
  }
}
