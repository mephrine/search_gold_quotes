// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';

import '../../../app/presentation/pages/intro/splash_page.dart';
import '../../../app/presentation/pages/main/main_page.dart';
import '../../../app/presentation/pages/main/video/video_player_page.dart';
import '../../../app/presentation/pages/setting/open_source_license_page.dart';
import '../../../app/presentation/pages/setting/setting_page.dart';
import '../../../app/presentation/pages/setting/theme_page.dart';
import '../../../app/presentation/pages/setting/version_info_page.dart';

class AppRoute {
  static const String splashPage = '/';
  static const String mainPage = '/main-page';
  static const String videoPlayerPage = '/video-player-page';
  static const String settingPage = '/setting-page';
  static const String openSourceLicensePage = '/open-source-license-page';
  static const String themePage = '/theme-page';
  static const String versionInfoPage = '/version-info-page';
  static const all = <String>{
    splashPage,
    mainPage,
    videoPlayerPage,
    settingPage,
    openSourceLicensePage,
    themePage,
    versionInfoPage,
  };
}

class AppRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(AppRoute.splashPage, page: SplashPage),
    RouteDef(AppRoute.mainPage, page: MainPage),
    RouteDef(AppRoute.videoPlayerPage, page: VideoPlayerPage),
    RouteDef(AppRoute.settingPage, page: SettingPage),
    RouteDef(AppRoute.openSourceLicensePage, page: OpenSourceLicensePage),
    RouteDef(AppRoute.themePage, page: ThemePage),
    RouteDef(AppRoute.versionInfoPage, page: VersionInfoPage),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    SplashPage: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => SplashPage(),
        settings: data,
      );
    },
    MainPage: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => MainPage(),
        settings: data,
      );
    },
    VideoPlayerPage: (data) {
      final args = data.getArgs<VideoPlayerPageArguments>(nullOk: false);
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => VideoPlayerPage(
          youtubeIDList: args.youtubeIDList,
          startIndex: args.startIndex,
        ),
        settings: data,
      );
    },
    SettingPage: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => SettingPage(),
        settings: data,
      );
    },
    OpenSourceLicensePage: (data) {
      final args = data.getArgs<OpenSourceLicensePageArguments>(nullOk: false);
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => OpenSourceLicensePage(title: args.title),
        settings: data,
      );
    },
    ThemePage: (data) {
      final args = data.getArgs<ThemePageArguments>(nullOk: false);
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => ThemePage(title: args.title),
        settings: data,
      );
    },
    VersionInfoPage: (data) {
      final args = data.getArgs<VersionInfoPageArguments>(nullOk: false);
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => VersionInfoPage(title: args.title),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// VideoPlayerPage arguments holder class
class VideoPlayerPageArguments {
  final List<String> youtubeIDList;
  final int startIndex;
  VideoPlayerPageArguments(
      {@required this.youtubeIDList, @required this.startIndex});
}

/// OpenSourceLicensePage arguments holder class
class OpenSourceLicensePageArguments {
  final String title;
  OpenSourceLicensePageArguments({@required this.title});
}

/// ThemePage arguments holder class
class ThemePageArguments {
  final String title;
  ThemePageArguments({@required this.title});
}

/// VersionInfoPage arguments holder class
class VersionInfoPageArguments {
  final String title;
  VersionInfoPageArguments({@required this.title});
}
