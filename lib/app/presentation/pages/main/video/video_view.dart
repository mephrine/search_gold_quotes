import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_gold_quotes/app/presentation/pages/main/video/video/video_bloc.dart';
import 'package:search_gold_quotes/core/di/injection_container.dart';

class VideoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => container<VideoBloc>(),
      child: VideoListWidget(),
    );
  }
}

class VideoListWidget extends StatefulWidget {
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
        return VideoItemWidget();
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }
}

class VideoItemWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
    );
  }
}
