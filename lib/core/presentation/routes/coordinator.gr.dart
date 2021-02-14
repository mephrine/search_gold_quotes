// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';

import '../../../app/presentation/pages/intro/splash_page.dart';
import '../../../app/presentation/pages/main/main_page.dart';
import '../../../app/presentation/pages/setting/setting_page.dart';

class Routes {
  static const String splashPage = '/';
  static const String mainPage = '/main-page';
  static const all = <String>{
    splashPage,
    mainPage,
  };
}

class Coordinator extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.splashPage, page: SplashPage),
    RouteDef(
      Routes.mainPage,
      page: MainPage,
      generator: MainPageRouter(),
    ),
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
  };
}

class MainPageRoutes {
  static const String settingPage = '/setting-page';
  static const all = <String>{
    settingPage,
  };
}

class MainPageRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(MainPageRoutes.settingPage, page: SettingPage),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    SettingPage: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => SettingPage(),
        settings: data,
        fullscreenDialog: true,
      );
    },
  };
}
