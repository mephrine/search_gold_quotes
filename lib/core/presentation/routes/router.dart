import 'package:auto_route/annotations.dart';
import 'package:search_gold_quotes/app/presentation/pages/intro/splash_page.dart';
import 'package:search_gold_quotes/app/presentation/pages/main/main_page.dart';
import 'package:search_gold_quotes/app/presentation/pages/main/video/video_player_page.dart';
import 'package:search_gold_quotes/app/presentation/pages/setting/open_source_license_page.dart';
import 'package:search_gold_quotes/app/presentation/pages/setting/setting_page.dart';
import 'package:search_gold_quotes/app/presentation/pages/setting/theme_page.dart';
import 'package:search_gold_quotes/app/presentation/pages/setting/version_info_page.dart';

@AdaptiveAutoRouter(
  replaceInRouteName: 'App,Route',
  routes: <AutoRoute>[
    AutoRoute(page: SplashPage, initial: true),
    AutoRoute(page: MainPage),
    AutoRoute(page: VideoPlayerPage),
    AutoRoute(page: SettingPage),
    AutoRoute(page: OpenSourceLicensePage),
    AutoRoute(page: ThemePage),
    AutoRoute(page: VersionInfoPage),
  ],
)
class $AppRouter {}