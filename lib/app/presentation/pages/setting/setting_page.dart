import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:search_gold_quotes/app/presentation/widgets/navigation_push_widget.dart';
import 'package:search_gold_quotes/core/di/injection_container.dart';
import 'package:search_gold_quotes/core/presentation/routes/router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:search_gold_quotes/core/theme/theme_notifier.dart';
import 'package:search_gold_quotes/core/values/dimens.dart' as dimens;
import 'package:search_gold_quotes/core/values/strings.dart' as strings;

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeNotifier themeService = Provider.of<ThemeNotifier>(context);
    return CupertinoApp(
      theme: themeService.getTheme(),
      home: SettingView(),
    );
  }
}

class SettingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavigationPushWidget(title: strings.titleSetting),
      body: ListView(
        children: [
          ListItemWidget(title: strings.titleTheme, routeAction: () { _pushToThemePage(context); }),
          SeparatorWidget(),
          ListItemWidget(title: strings.titleOpenSourceLicense, routeAction: () { _pushToOpenSourceLicensePage(context); }),
          SeparatorWidget(),
          ListItemWidget(title: strings.titleVersionInfo, routeAction: () { _pushToVersionInfoPage(context); }),
        ],
        padding: EdgeInsets.fromLTRB(dimens.margin, dimens.spacing, dimens.margin, dimens.spacing),
      ),
    );
  }

  void _pushToThemePage(BuildContext context) {
    context.router.push(ThemePage());
  }

  void _pushToOpenSourceLicensePage(BuildContext context) {
    context.router.push(OpenSourceLicensePage());
  }

  void _pushToVersionInfoPage(BuildContext context) {
    context.router.push(VersionInfoPage());
  }
}

class SeparatorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      color: CupertinoTheme.of(context).primaryContrastingColor,
      padding: EdgeInsets.all(dimens.margin),
    );
  }
}

class ListItemWidget extends StatelessWidget {
  final String title;
  final Function routeAction;

  ListItemWidget({
    @required this.title,
    @required this.routeAction
  });

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
              style: TextStyle(fontSize: dimens.fontTextBig),
            ),
            const Spacer(),
            Icon(
              Icons.keyboard_arrow_right,
              size: dimens.iconSizeTitle,
              color: CupertinoTheme.of(context).primaryContrastingColor,
            ),
          ],
        ),
      )
    );
  }
}
