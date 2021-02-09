import 'package:flutter/foundation.dart' as foundation;

class DeviceUtils {
static bool get isAndroid =>
    foundation.defaultTargetPlatform == foundation.TargetPlatform.android;
}