import 'package:flutter/foundation.dart' as foundation;
import 'package:package_info/package_info.dart';

bool get isAndroid =>
    foundation.defaultTargetPlatform == foundation.TargetPlatform.android;

Future<String> get version async {
  final packageInfo = await PackageInfo.fromPlatform();
  return packageInfo.version;
}