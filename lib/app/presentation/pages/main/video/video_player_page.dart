import 'package:dartz/dartz.dart' as dartz;
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:search_gold_quotes/app/presentation/pages/main/video/widget/video_meta_data_widget.dart';
import 'package:search_gold_quotes/app/presentation/pages/main/video/widget/video_player_button_bar_widget.dart';
import 'package:search_gold_quotes/app/presentation/style/TextStyles.dart';
import 'package:search_gold_quotes/app/presentation/widgets/navigation_push_widget.dart';
import 'package:search_gold_quotes/core/theme/theme_notifier.dart';
import 'package:search_gold_quotes/core/values/strings.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class VideoPlayerPage extends StatelessWidget {
  final List<dartz.Tuple2<String, String>> youtubeIDList;

  final int startIndex;

  VideoPlayerPage({@required this.youtubeIDList, @required this.startIndex});

  @override
  Widget build(BuildContext context) {
    ThemeNotifier themeService = Provider.of<ThemeNotifier>(context);
    return MaterialApp(
      theme: themeService.getTheme(),
      home: _VideoPlayerView(youtubeIDList: youtubeIDList, index: startIndex),
    );
  }
}

/// Homepage
// ignore: must_be_immutable
class _VideoPlayerView extends StatefulWidget {
  final List<dartz.Tuple2<String, String>> youtubeIDList;
  final int index;

  _VideoPlayerView({@required this.youtubeIDList, @required this.index});

  @override
  _VideoPlayerViewState createState() => _VideoPlayerViewState();
}

class _VideoPlayerViewState extends State<_VideoPlayerView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.youtubeIDList[widget.index].value2,
      params: const YoutubePlayerParams(
        mute: false,
        autoPlay: true,
        loop: false,
        enableCaption: true,
        showControls: true,
        showFullscreenButton: true,
        desktopMode: true,
        privacyEnhanced: true,
        useHybridComposition: true,
      ),
    );
    _controller.onEnterFullscreen = () {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    };
    _controller.onExitFullscreen = () {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
    };
  }

  // void listener() {
  //   if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
  //     setState(() {
  //       _videoMetaData = _controller.metadata;
  //     });
  //   }
  // }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.close();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const player = YoutubePlayerIFrame();
    return YoutubePlayerControllerProvider(
      // Passing controller to widgets below.
      controller: _controller,
      child: portraitScalffold(player),
    );
  }

  Widget portraitScalffold(YoutubePlayerIFrame player) => Scaffold(
        key: _scaffoldKey,
        appBar: NavigationPushWidget(
          title: widget.youtubeIDList[widget.index].value1,
        ),
        body: ListView(
          children: [
            player,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _space,
                  VideoMetaDataWidget(),
                  _space,
                  VideoPlayPauseButtonBarWidget(
                      youtubeIdList:
                          widget.youtubeIDList.map((e) => e.value2).toList(),
                      index: widget.index)
                ],
              ),
            ),
          ],
        ),
      );

  Widget get _space => const SizedBox(height: 10);
}
