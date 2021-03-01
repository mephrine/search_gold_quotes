import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:search_gold_quotes/app/domain/usecases/get_video_list.dart';

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

    }
  }
}
