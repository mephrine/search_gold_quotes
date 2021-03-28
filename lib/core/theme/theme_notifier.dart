import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:search_gold_quotes/core/platform/device_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppTheme { system, light, dark }

extension ThemeStyles on AppTheme {
  String value() {
    switch (this) {
      case AppTheme.system:
        return 'system';
      case AppTheme.light:
        return 'light';
      case AppTheme.dark:
        return 'dark';
      default:
        return 'light';
    }
  }

  int modeValue() {
    switch (this) {
      case AppTheme.light:
        return 0;
      case AppTheme.dark:
        return 1;
      case AppTheme.system:
        return 2;
      default:
        return 0;
    }
  }
}

class ThemeNotifier with ChangeNotifier {
  static const String KEY_THEME_MODE = 'themeMode';
  final SharedPreferences preferences;

  final darkTheme = ThemeData(
    //Text color
    primaryColorDark: Colors.white,
    primaryColorLight: Colors.black,
    primaryColor: Colors.white,
    brightness: Brightness.dark,
    backgroundColor: Colors.black,
    indicatorColor: Colors.white,
    scaffoldBackgroundColor: Colors.black,
    // dialogBackgroundColor: Colors.black54,
    bottomAppBarColor: Colors.black,
    accentColor: Colors.black,
  );

  final lightTheme = ThemeData(
    primaryColorDark: Colors.black,
    primaryColorLight: Colors.white,
    primaryColor: Colors.black,
    brightness: Brightness.light,
    backgroundColor: Colors.white,
    indicatorColor: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    // dialogBackgroundColor: Colors.white,
    bottomAppBarColor: Colors.white,
    accentColor: Colors.blue,
  );

  ThemeData _themeData;

  ThemeData getTheme() => _themeData;

  ThemeNotifier({@required this.preferences}) {
    AppTheme themeMode = getThemeMode();
    if (themeMode == AppTheme.system) {
      themeMode = _getSystemAppTheme();
    }

    if (themeMode == AppTheme.light) {
      print('setting light theme');
      _themeData = lightTheme;
    } else {
      print('setting dark theme');
      _themeData = darkTheme;
    }
    notifyListeners();
  }

  AppTheme _getSystemAppTheme() {
    try {
      return DeviceUtils.isDarkTheme ? AppTheme.dark : AppTheme.light;
    } catch (nullPointException) {
      return AppTheme.light;
    }
  }

  AppTheme getThemeMode() {
    String themeMode = preferences.get(KEY_THEME_MODE);
    if (null == themeMode) {
      return AppTheme.system;
    }

    if (themeMode == AppTheme.light.value()) {
      return AppTheme.light;
    } else if (themeMode == AppTheme.dark.value()) {
      return AppTheme.dark;
    }

    return AppTheme.system;
  }

  bool getThemeIsDark() {
    String themeMode = preferences.get(KEY_THEME_MODE);
    if (themeMode == AppTheme.dark.value()) {
      return true;
    }
    return false;
  }

  void setDarkMode() async {
    _themeData = darkTheme;
    preferences.setString(KEY_THEME_MODE, AppTheme.dark.value());
    notifyListeners();
  }

  void setLightMode() async {
    _themeData = lightTheme;
    preferences.setString(KEY_THEME_MODE, AppTheme.light.value());
    notifyListeners();
  }

  void setSystemMode() async {
    _themeData =
        _getSystemAppTheme() == AppTheme.light ? lightTheme : darkTheme;
    preferences.setString(KEY_THEME_MODE, AppTheme.system.value());
    notifyListeners();
  }
}
