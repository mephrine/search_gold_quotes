part of 'video_bloc.dart';

@immutable
abstract class VideoState extends Equatable{}

class InitialVideoState extends VideoState {
  @override
  List<Object> get props => const <dynamic>[];
}

class Empty extends InitialVideoState {}

class Loading extends InitialVideoState {}

class Loaded extends InitialVideoState {}

class Error extends InitialVideoState {}