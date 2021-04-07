import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_gold_quotes/core/platform/device_utils.dart';
import 'package:search_gold_quotes/core/theme/theme_notifier.dart';

class VideoThumnailPlaceHolderWidget extends StatelessWidget {
  final String placeHolderDarkAsset = 'images/placeholder_white.png';
  final String placeHolderLightAsset = 'images/placeholder_black.png';

  @override
  Widget build(BuildContext context) {
    var themeService = Provider.of<ThemeNotifier>(context);
    return Container(
      height: 200,
      width: DeviceUtils.screenWidth(context),
      decoration: new BoxDecoration(
          image: new DecorationImage(
        image: AssetImage(themeService.getThemeIsDark()
            ? placeHolderDarkAsset
            : placeHolderLightAsset),
      )),
    );
  }
}
