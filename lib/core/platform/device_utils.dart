import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/widgets.dart';
import 'package:package_info/package_info.dart';

bool get isAndroid =>
    foundation.defaultTargetPlatform == foundation.TargetPlatform.android;

Future<String> get version async {
  final packageInfo = await PackageInfo.fromPlatform();
  return packageInfo.version;
}

Size screenSize(BuildContext context) => MediaQuery.of(context).size;

double screenWidth(BuildContext context) => screenSize(context).width;

double screenHeight(BuildContext context) => screenSize(context).height;