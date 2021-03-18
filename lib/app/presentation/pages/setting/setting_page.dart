import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_gold_quotes/app/presentation/widgets/navigation_push_widget.dart';
import 'package:search_gold_quotes/app/presentation/widgets/separator_widget.dart';
import 'package:search_gold_quotes/core/di/injection_container.dart';
import 'package:search_gold_quotes/core/presentation/routes/router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:search_gold_quotes/core/theme/theme_notifier.dart';
import 'package:search_gold_quotes/core/values/dimens.dart';
import 'package:search_gold_quotes/core/values/strings.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeNotifier themeService = Provider.of<ThemeNotifier>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeService.getTheme(),
      home: SettingView(),
    );
  }
}

class SettingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavigationPushWidget(title: Strings.titleSetting),
      body: ListView(
        children: [
          ListItemWidget(
              title: Strings.titleTheme,
              routeAction: () {
                _pushToThemePage(context, Strings.titleTheme);
              }),
          SeparatorWidget(),
          ListItemWidget(
              title: Strings.titleOpenSourceLicense,
              routeAction: () {
                _pushToOpenSourceLicensePage(
                    context, Strings.titleOpenSourceLicense);
              }),
          SeparatorWidget(),
          ListItemWidget(
              title: Strings.titleVersionInfo,
              routeAction: () {
                _pushToVersionInfoPage(context, Strings.titleVersionInfo);
              }),
        ],
        padding: EdgeInsets.fromLTRB(
            Dimens.margin, Dimens.spacing, Dimens.margin, Dimens.spacing),
      ),
    );
  }

  void _pushToThemePage(BuildContext context, String title) {
    context.router.push(ThemePage(title: title));
  }

  void _pushToOpenSourceLicensePage(BuildContext context, String title) {
    context.router.push(OpenSourceLicensePage(title: title));
  }

  void _pushToVersionInfoPage(BuildContext context, String title) {
    context.router.push(VersionInfoPage(title: title));
  }
}

class ListItemWidget extends StatelessWidget {
  final String title;
  final Function routeAction;

  ListItemWidget({@required this.title, @required this.routeAction});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => routeAction(),
        child: Container(
          height: 68,
          child: Row(
            children: [
              Text(
                title,
                style: TextStyle(fontSize: Dimens.fontTextBig),
              ),
              const Spacer(),
              Icon(
                Icons.keyboard_arrow_right,
                size: Dimens.iconSizeTitle,
                color: Colors.white,
              ),
            ],
          ),
        ));
  }
}
