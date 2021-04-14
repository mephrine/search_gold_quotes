import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class VideoPlayPauseButtonBarWidget extends StatelessWidget {
  final List<String> youtubeIdList;
  int index;
  final ValueNotifier<bool> _isMuted = ValueNotifier(false);

  VideoPlayPauseButtonBarWidget(
      {@required this.youtubeIdList, @required this.index});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
            icon: const Icon(Icons.skip_previous),
            onPressed: () => context.ytController.load(_prevVideoID())),
        YoutubeValueBuilder(
          builder: (context, value) {
            return IconButton(
              icon: Icon(
                value.playerState == PlayerState.playing
                    ? Icons.pause
                    : Icons.play_arrow,
              ),
              onPressed: value.isReady
                  ? () {
                      value.playerState == PlayerState.playing
                          ? context.ytController.pause()
                          : context.ytController.play();
                    }
                  : null,
            );
          },
        ),
        ValueListenableBuilder<bool>(
          valueListenable: _isMuted,
          builder: (context, isMuted, _) {
            return IconButton(
              icon: Icon(isMuted ? Icons.volume_off : Icons.volume_up),
              onPressed: () {
                _isMuted.value = !isMuted;
                isMuted
                    ? context.ytController.unMute()
                    : context.ytController.mute();
              },
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.skip_next),
          onPressed: () => context.ytController.load(_nextVideoID()),
        ),
      ],
    );
  }

  String _nextVideoID() {
    index = (index + 1) % youtubeIdList.length;
    return youtubeIdList[index];
  }

  String _prevVideoID() {
    index = (index - 1) % youtubeIdList.length;
    return youtubeIdList[index];
  }
}
