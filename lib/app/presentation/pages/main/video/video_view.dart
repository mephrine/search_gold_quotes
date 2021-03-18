import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:search_gold_quotes/app/domain/entities/video_items.dart';
import 'package:search_gold_quotes/app/presentation/pages/main/video/video/video_bloc.dart';
import 'package:search_gold_quotes/app/presentation/style/TextStyles.dart';
import 'package:search_gold_quotes/app/presentation/widgets/message_display.dart';
import 'package:search_gold_quotes/app/presentation/widgets/navigation_main_scrollable_widget.dart';
import 'package:search_gold_quotes/core/di/injection_container.dart';
import 'package:search_gold_quotes/core/presentation/routes/router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:search_gold_quotes/core/theme/theme_notifier.dart';
import 'package:search_gold_quotes/core/values/dimens.dart';
import 'package:search_gold_quotes/core/values/strings.dart';
import 'package:shimmer/shimmer.dart';

class VideoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => container<VideoBloc>(),
      child: Container(
        color: Theme.of(context).accentColor,
        child: SafeArea(
          child: CustomScrollView(slivers: [
            NavigationMainScrollableWidget(title: Strings.titleVideo),
            SliverToBoxAdapter(
              child: VideoContainer(),
            )
          ]),
        ),
      ),
    );
  }
}

class VideoContainer extends StatefulWidget {
  @override
  _VideoContainer createState() => _VideoContainer();
}

class _VideoContainer extends State<VideoContainer> {
  @override
  void initState() {
    super.initState();
    _dispatchVideoData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VideoBloc, VideoState>(builder: (bloc, state) {
      if (state is Loading) {
        return LoadingListWidget();
      } else if (state is Loaded) {
        return VideoListWidget(videoList: state.videoList);
      } else if (state is Error) {
        return MessageDisplay(message: state.message);
      }
      return Container();
    });
  }

  void _dispatchVideoData() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<VideoBloc>(context, listen: false)
          .add(GetVideoListOnLoaded());
    });
  }
}

class LoadingListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200.0,
      height: 100.0,
      child: Shimmer.fromColors(
        baseColor: Colors.red,
        highlightColor: Colors.yellow,
        child: Text(
          'Shimmer',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 40.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
    ;
  }
}

class VideoListWidget extends StatefulWidget {
  final VideoList videoList;

  VideoListWidget({@required this.videoList});

  @override
  _VideoListWidget createState() => _VideoListWidget();
}

class _VideoListWidget extends State<VideoListWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(Dimens.margin),
      shrinkWrap: true,
      itemCount: widget.videoList.itemList.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          child: VideoItemWidget(
              videoItem: widget.videoList.itemList[index], isDarkTheme: false),
          onTap: () => _pushToVideoPlayerPage(context, index),
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }

  void _pushToVideoPlayerPage(BuildContext context, int index) {
    context.router.push(VideoPlayerPage(
        youtubeIDList:
            widget.videoList.itemList.map((item) => item.linkURL).toList(),
        startIndex: index));
  }
}

class VideoItemWidget extends StatelessWidget {
  final VideoItem videoItem;
  final bool isDarkTheme;

  VideoItemWidget({@required this.videoItem, @required this.isDarkTheme});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(videoItem.imagePath),
                  fit: BoxFit.fitWidth)),
          height: 200,
          width: MediaQuery.of(context).size.width,
          child: Image.asset('images/placeholder_black.png'),
          // Image.network(
          //   videoItem.imagePath,
          //   fit: BoxFit.cover,
          //   frameBuilder: (ctx, child, frame, wasSynchronouslyLoaded) {
          //     if (wasSynchronouslyLoaded) return child;

          //     return Stack(children: <Widget>[
          //       AnimatedOpacity(
          //         opacity: frame == null ? 1 : 0,
          //         duration: Duration(seconds: 1),
          //         child: frame == null
          //             ? isDarkTheme
          //                 ? Image.asset('images/placeholder_white.png')
          //                 : Image.asset('images/placeholder_black.png')
          //             : null,
          //       ),
          //       AnimatedOpacity(
          //           opacity: frame == null ? 0 : 1,
          //           duration: Duration(seconds: 1),
          //           child: frame != null ? child : null),
          //     ]);
          //   },
          // ),
        ),
        Text(videoItem.title,
            textAlign: TextAlign.start,
            maxLines: 2,
            style: TextPrimaryStyles.titleStyle(context)),
        Text(videoItem.subTitle,
            textAlign: TextAlign.start,
            maxLines: 2,
            style: TextPrimaryStyles.defaultStyle(context)),
      ],
    );
  }
}
