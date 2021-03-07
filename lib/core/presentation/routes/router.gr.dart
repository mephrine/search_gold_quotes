// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i9;

import '../../../app/presentation/pages/intro/splash_page.dart' as _i2;
import '../../../app/presentation/pages/main/main_page.dart' as _i3;
import '../../../app/presentation/pages/main/video/video_player_page.dart'
    as _i4;
import '../../../app/presentation/pages/setting/open_source_license_page.dart'
    as _i6;
import '../../../app/presentation/pages/setting/setting_page.dart' as _i5;
import '../../../app/presentation/pages/setting/theme_page.dart' as _i7;
import '../../../app/presentation/pages/setting/version_info_page.dart' as _i8;

class AppRouter extends _i1.RootStackRouter {
  AppRouter();

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    SplashPage.name: (entry) {
      return _i1.AdaptivePage(entry: entry, child: _i2.SplashPage());
    },
    MainPage.name: (entry) {
      return _i1.AdaptivePage(entry: entry, child: _i3.MainPage());
    },
    VideoPlayerPage.name: (entry) {
      var route = entry.routeData.as<VideoPlayerPage>();
      return _i1.AdaptivePage(
          entry: entry,
          child: _i4.VideoPlayerPage(
              youtubeIDList: route.youtubeIDList,
              startIndex: route.startIndex));
    },
    SettingPage.name: (entry) {
      return _i1.AdaptivePage(entry: entry, child: _i5.SettingPage());
    },
    OpenSourceLicensePage.name: (entry) {
      return _i1.AdaptivePage(entry: entry, child: _i6.OpenSourceLicensePage());
    },
    ThemePage.name: (entry) {
      return _i1.AdaptivePage(entry: entry, child: _i7.ThemePage());
    },
    VersionInfoPage.name: (entry) {
      return _i1.AdaptivePage(entry: entry, child: _i8.VersionInfoPage());
    }
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig<SplashPage>(SplashPage.name,
            path: '/', routeBuilder: (match) => SplashPage.fromMatch(match)),
        _i1.RouteConfig<MainPage>(MainPage.name,
            path: '/main-page',
            routeBuilder: (match) => MainPage.fromMatch(match)),
        _i1.RouteConfig<VideoPlayerPage>(VideoPlayerPage.name,
            path: '/video-player-page',
            routeBuilder: (match) => VideoPlayerPage.fromMatch(match)),
        _i1.RouteConfig<SettingPage>(SettingPage.name,
            path: '/setting-page',
            routeBuilder: (match) => SettingPage.fromMatch(match)),
        _i1.RouteConfig<OpenSourceLicensePage>(OpenSourceLicensePage.name,
            path: '/open-source-license-page',
            routeBuilder: (match) => OpenSourceLicensePage.fromMatch(match)),
        _i1.RouteConfig<ThemePage>(ThemePage.name,
            path: '/theme-page',
            routeBuilder: (match) => ThemePage.fromMatch(match)),
        _i1.RouteConfig<VersionInfoPage>(VersionInfoPage.name,
            path: '/version-info-page',
            routeBuilder: (match) => VersionInfoPage.fromMatch(match))
      ];
}

class SplashPage extends _i1.PageRouteInfo {
  const SplashPage() : super(name, path: '/');

  SplashPage.fromMatch(_i1.RouteMatch match) : super.fromMatch(match);

  static const String name = 'SplashPage';
}

class MainPage extends _i1.PageRouteInfo {
  const MainPage() : super(name, path: '/main-page');

  MainPage.fromMatch(_i1.RouteMatch match) : super.fromMatch(match);

  static const String name = 'MainPage';
}

class VideoPlayerPage extends _i1.PageRouteInfo {
  VideoPlayerPage(
      {@_i9.required this.youtubeIDList, @_i9.required this.startIndex})
      : super(name, path: '/video-player-page');

  VideoPlayerPage.fromMatch(_i1.RouteMatch match)
      : youtubeIDList = null,
        startIndex = null,
        super.fromMatch(match);

  final List<String> youtubeIDList;

  final int startIndex;

  static const String name = 'VideoPlayerPage';
}

class SettingPage extends _i1.PageRouteInfo {
  const SettingPage() : super(name, path: '/setting-page');

  SettingPage.fromMatch(_i1.RouteMatch match) : super.fromMatch(match);

  static const String name = 'SettingPage';
}

class OpenSourceLicensePage extends _i1.PageRouteInfo {
  const OpenSourceLicensePage()
      : super(name, path: '/open-source-license-page');

  OpenSourceLicensePage.fromMatch(_i1.RouteMatch match)
      : super.fromMatch(match);

  static const String name = 'OpenSourceLicensePage';
}

class ThemePage extends _i1.PageRouteInfo {
  const ThemePage() : super(name, path: '/theme-page');

  ThemePage.fromMatch(_i1.RouteMatch match) : super.fromMatch(match);

  static const String name = 'ThemePage';
}

class VersionInfoPage extends _i1.PageRouteInfo {
  const VersionInfoPage() : super(name, path: '/version-info-page');

  VersionInfoPage.fromMatch(_i1.RouteMatch match) : super.fromMatch(match);

  static const String name = 'VersionInfoPage';
}
