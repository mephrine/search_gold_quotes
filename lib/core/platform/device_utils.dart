import 'dart:ui';

import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:package_info/package_info.dart';

class DeviceUtils {
  static bool get isAndroid =>
      foundation.defaultTargetPlatform == foundation.TargetPlatform.android;

  static Future<String> get version async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      return packageInfo.version;
    } catch (exception) {
      return '1.0.0';
    }
  }

  static Size screenSize(BuildContext context) => MediaQuery.of(context).size;

  static double screenWidth(BuildContext context) => screenSize(context).width;

  static double screenHeight(BuildContext context) =>
      screenSize(context).height;

  static bool isDarkTheme =
      (SchedulerBinding.instance.window.platformBrightness ??
              Brightness.light) ==
          Brightness.dark;
}
