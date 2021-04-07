part of 'video_bloc.dart';

@immutable
abstract class VideoEvent {}

class GetVideoListOnLoaded extends VideoEvent {}

class RefreshVideoList extends VideoEvent {}
