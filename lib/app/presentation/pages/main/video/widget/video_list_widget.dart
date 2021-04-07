import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:search_gold_quotes/app/domain/entities/video_items.dart';
import 'package:search_gold_quotes/app/presentation/pages/main/video/bloc/video_bloc.dart';
import 'package:search_gold_quotes/app/presentation/pages/main/video/widget/video_thumnail_place_holder_widget.dart';
import 'package:search_gold_quotes/app/presentation/style/TextStyles.dart';
import 'package:search_gold_quotes/core/platform/device_utils.dart';
import 'package:search_gold_quotes/core/presentation/routes/router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:search_gold_quotes/core/values/dimens.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart' as dartz;

class VideoListWidget extends StatefulWidget {
  final VideoList videoList;

  VideoListWidget({Key key, @required this.videoList});

  @override
  _VideoListWidgetState createState() => _VideoListWidgetState();
}

class _VideoListWidgetState extends State<VideoListWidget> {
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
    return RefreshIndicator(
      child: ListView.separated(
        padding: const EdgeInsets.all(Dimens.margin),
        shrinkWrap: true,
        itemCount: widget.videoList.itemList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            behavior: HitTestBehavior.translucent,
            child: VideoItemWidget(videoItem: widget.videoList.itemList[index]),
            onTap: () => _pushToVideoPlayerPage(context, index),
          );
        },
        separatorBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: Dimens.spacing),
            child: Divider(),
          );
        },
      ),
      onRefresh: _onRefresh,
    );
  }

  void _pushToVideoPlayerPage(BuildContext context, int index) {
    context.rootNavigator.push(AppRoute.videoPlayerPage,
        arguments: VideoPlayerPageArguments(
            youtubeIDList: widget.videoList.itemList
                .map((item) => dartz.Tuple2(item.title, item.linkURL))
                .toList(),
            startIndex: index));
  }

  Future<void> _onRefresh() async {
    context.read<VideoBloc>().add(RefreshVideoList());
  }
}

class VideoItemWidget extends StatelessWidget {
  final VideoItem videoItem;

  VideoItemWidget({@required this.videoItem});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        videoItem.imagePath != null
            ? CachedNetworkImage(
                fit: BoxFit.fitWidth,
                imageUrl: videoItem.imagePath,
                imageBuilder: (context, imageProvider) => Container(
                  height: 200,
                  width: DeviceUtils.screenWidth(context),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.fitWidth,
                  )),
                ),
                placeholder: (context, url) => VideoThumnailPlaceHolderWidget(),
                errorWidget: (context, url, error) =>
                    VideoThumnailPlaceHolderWidget(),
              )
            : VideoThumnailPlaceHolderWidget(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: Dimens.spacing),
          child: Text(videoItem.title,
              textAlign: TextAlign.start,
              maxLines: 2,
              style: TextPrimaryContrastingStyles.titleStyle(context)),
        ),
        Text(videoItem.subTitle,
            textAlign: TextAlign.start,
            maxLines: 2,
            style: TextPrimaryContrastingStyles.defaultStyle(context)),
      ],
    );
  }
}
