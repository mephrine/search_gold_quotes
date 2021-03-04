import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:search_gold_quotes/app/domain/entities/video_items.dart';
import 'package:search_gold_quotes/app/domain/usecases/get_video_list.dart';
import 'package:search_gold_quotes/core/error/failures.dart';
import 'package:search_gold_quotes/core/usecases/no_params.dart';
import 'package:search_gold_quotes/core/values/strings.dart';

part 'video_event.dart';
part 'video_state.dart';

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  GetVideoList getVideoList;

  VideoBloc({
    @required GetVideoList videoListUsecase
  })
      : assert(videoListUsecase != null),
        getVideoList = videoListUsecase,
        super(Empty());

  @override
  VideoState get initialState => Empty();

  @override
  Stream<VideoState> mapEventToState(VideoEvent event) async* {
    if (event is GetVideoListOnLoaded) {
      yield Loading();
      final videoList = await getVideoList(NoParams());
      yield videoList.fold((failure) => Error(message: _mapFailureToErrorMessage(failure)), (videoList) => Loaded(videoList: videoList));
    }
  }

  String _mapFailureToErrorMessage(Failure failure) {
    switch(failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case ParseFailure:
        return PARSE_FAILURE_MESSAGE;
      default:
        return SERVER_FAILURE_MESSAGE;
    }
  }
}
