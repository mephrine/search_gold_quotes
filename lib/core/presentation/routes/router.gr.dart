// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i6;

import '../../../app/presentation/pages/intro/splash_page.dart' as _i2;
import '../../../app/presentation/pages/main/main_page.dart' as _i3;
import '../../../app/presentation/pages/main/video/video_player_page.dart'
    as _i4;
import '../../../app/presentation/pages/setting/setting_page.dart' as _i5;

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
            routeBuilder: (match) => SettingPage.fromMatch(match))
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
      {@_i6.required this.youtubeIDList, @_i6.required this.startIndex})
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
