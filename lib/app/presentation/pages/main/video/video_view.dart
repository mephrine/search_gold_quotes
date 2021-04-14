import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_gold_quotes/app/presentation/pages/main/video/bloc/video_bloc.dart';
import 'package:search_gold_quotes/app/presentation/pages/main/video/widget/video_list_loading_widget.dart';
import 'package:search_gold_quotes/app/presentation/pages/main/video/widget/video_list_widget.dart';
import 'package:search_gold_quotes/app/presentation/widgets/message_display.dart';
import 'package:search_gold_quotes/app/presentation/widgets/navigation_main_widget.dart';
import 'package:search_gold_quotes/core/di/injection_container.dart';
import 'package:search_gold_quotes/core/values/strings.dart';

class VideoView extends StatelessWidget {
  const VideoView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => container<VideoBloc>()..add(GetVideoListOnLoaded()),
        child: _VideoContainer());
  }
}

class _VideoContainer extends StatefulWidget {
  _VideoContainer({Key key}) : super(key: key);

  @override
  _VideoContainerState createState() => _VideoContainerState();
}

class _VideoContainerState extends State<_VideoContainer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: NavigationMainWidget(title: Strings.titleVideo),
        body: BlocBuilder<VideoBloc, VideoState>(
          builder: (bloc, state) {
            if (state is Loading) {
              return VideoListLoadingWidget();
            } else if (state is Loaded) {
              return VideoListWidget(videoList: state.videoList);
            } else if (state is Error) {
              return MessageDisplay(message: state.message);
            }
            return Container();
          },
        ));
  }
}
