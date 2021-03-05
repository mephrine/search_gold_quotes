import 'package:auto_route/annotations.dart';
import 'package:search_gold_quotes/app/presentation/pages/intro/splash_page.dart';
import 'package:search_gold_quotes/app/presentation/pages/main/main_page.dart';
import 'package:search_gold_quotes/app/presentation/pages/setting/setting_page.dart';

@AdaptiveAutoRouter(
  replaceInRouteName: 'App,Route',
  routes: <AutoRoute>[
    AutoRoute(page: SplashPage, initial: true),
    AutoRoute(page: MainPage),
    AutoRoute(page: SettingPage),
  ],
)
class $AppRouter {}