import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_gold_quotes/app/domain/entities/video_items.dart';
import 'package:search_gold_quotes/app/number_trivia/presentation/widgets/message_display.dart';
import 'package:search_gold_quotes/app/presentation/pages/main/video/video/video_bloc.dart';
import 'package:search_gold_quotes/core/di/injection_container.dart';
import 'package:shimmer/shimmer.dart';

class VideoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => container<VideoBloc>(),
      child: BlocBuilder<VideoBloc, VideoState>(builder: (bloc, state) {
        if (state is Empty) {
          return Container();
        } else if (state is Loading) {
          return LoadingListWidget();
        } else if (state is Loaded) {
          return VideoListWidget(videoList: state.videoList);
        } else if (state is Error) {
          return MessageDisplay(message: state.message);
        }
      }),
    );
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
      padding: const EdgeInsets.all(16),
      itemCount: 10,
      itemBuilder: (context, index) {
        return VideoItemWidget(
          videoItem: widget.videoList.itemList[index],
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }
}

class VideoItemWidget extends StatelessWidget {
  final VideoItem videoItem;

  VideoItemWidget({@required this.videoItem});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(
          videoItem.imagePath,
          fit: BoxFit.cover,
          frameBuilder: (ctx, child, frame, wasSynchronouslyLoaded) {
            if (wasSynchronouslyLoaded) return child;

            return Stack(children: <Widget>[
              AnimatedOpacity(
                opacity: frame == null ? 1 : 0,
                duration: Duration(seconds: 1),
                child: frame == null ? Image.asset('images/logo.png') : null,
              ),
              AnimatedOpacity(
                  opacity: frame == null ? 0 : 1,
                  duration: Duration(seconds: 1),
                  child: frame != null ? child : null),
            ]);
          },
        ),
        Text(videoItem.title),
        Text(videoItem.subTitle)
      ],
    );
  }
}
