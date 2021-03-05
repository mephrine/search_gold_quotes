// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;

import '../../../app/presentation/pages/intro/splash_page.dart' as _i2;
import '../../../app/presentation/pages/main/main_page.dart' as _i3;
import '../../../app/presentation/pages/setting/setting_page.dart' as _i4;

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
    SettingPage.name: (entry) {
      return _i1.AdaptivePage(entry: entry, child: _i4.SettingPage());
    }
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig<SplashPage>(SplashPage.name,
            path: '/', routeBuilder: (match) => SplashPage.fromMatch(match)),
        _i1.RouteConfig<MainPage>(MainPage.name,
            path: '/main-page',
            routeBuilder: (match) => MainPage.fromMatch(match)),
        _i1.RouteConfig<SettingPage>(SettingPage.name,
            path: 'setting-page',
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

class SettingPage extends _i1.PageRouteInfo {
  const SettingPage() : super(name, path: '/setting-page');

  SettingPage.fromMatch(_i1.RouteMatch match) : super.fromMatch(match);

  static const String name = 'SettingPage';
}
