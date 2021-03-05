import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:search_gold_quotes/app/presentation/widgets/navigation_push_widget.dart';
import 'package:search_gold_quotes/core/di/injection_container.dart';
import 'package:search_gold_quotes/core/theme/theme_notifier.dart';
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
            ListItemWidget(title: strings.titleTheme),
            ListItemWidget(title: strings.titleOpenSourceLicense),
            ListItemWidget(title: strings.titleVersionInfo),
          ],
      ),
    );
  }
}

class ListItemWidget extends StatelessWidget {
  final String title;

  ListItemWidget({
    @required this.title
  });

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


