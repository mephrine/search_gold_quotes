import 'package:flutter/material.dart';
import 'package:search_gold_quotes/core/platform/device_utils.dart';
import 'package:search_gold_quotes/core/values/dimens.dart';
import 'package:shimmer/shimmer.dart';

class VideoListLoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
      enabled: true,
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        padding: const EdgeInsets.all(Dimens.margin),
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (context, index) {
          return _LoadingListItemWidget();
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
      ),
    );
  }
}

class _LoadingListItemWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(height: 200, width: double.infinity, color: Colors.white),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 5.0),
        ),
        Container(
            width: DeviceUtils.screenWidth(context),
            height: 44,
            color: Colors.white),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 3.0),
        ),
        Container(
            width: DeviceUtils.screenWidth(context) / 2,
            height: 22,
            color: Colors.white),
      ],
    );
  }
}
