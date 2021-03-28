part of 'video_bloc.dart';

@immutable
abstract class VideoState extends Equatable {}

class InitialVideoState extends VideoState {
  @override
  List<Object> get props => const <dynamic>[];
}

class Empty extends InitialVideoState {}

class Loading extends InitialVideoState {}

class Loaded extends InitialVideoState {
  final VideoList videoList;

  Loaded({@required this.videoList});
}

class Error extends InitialVideoState {
  final String message;

  Error({@required this.message});
}
