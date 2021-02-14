import 'package:auto_route/auto_route.dart';
import 'package:auto_route_generator/route_config_resolver.dart';
import 'package:auto_route/auto_route_annotations.dart';
import 'package:search_gold_quotes/app/presentation/pages/intro/splash_page.dart';
import 'package:search_gold_quotes/app/presentation/pages/main/main_page.dart';
import 'package:search_gold_quotes/app/presentation/pages/setting/setting_page.dart';
import 'coordinator.gr.dart';

@AdaptiveAutoRouter(routes: <AutoRoute>[
  AdaptiveRoute(page: SplashPage, initial: true),
  AdaptiveRoute(page: MainPage, children: <AutoRoute> [
    AdaptiveRoute(page: SettingPage, fullscreenDialog: true),
  ]),
])

class $Coordinator{}

extension RouterNavigationHelper on ExtendedNavigatorState {
  Future pushMainPage() => push(Routes.mainPage);
}