import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:search_gold_quotes/core/di/injection_container.dart';
import 'package:search_gold_quotes/core/theme/theme_notifier.dart';
import 'package:search_gold_quotes/core/values/dimens.dart' as dimens;
import 'package:search_gold_quotes/core/values/strings.dart' as strings;

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) =>
            container<ThemeNotifier>()
        ,
        child: Consumer<ThemeNotifier>(
            builder: (context, ThemeNotifier theme, child) {
              return CupertinoApp(
                theme: theme.getTheme(),
                home: SettingView(),
              );
            }
        )
    );
  }
}

class SettingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavigationPushWidget(title: strings.titleSetting) ,
    );
  }
}

class NavigationPushWidget extends StatelessWidget with PreferredSizeWidget {
  final String title;

  const NavigationPushWidget({@required this.title});

  @override
  Widget build(BuildContext context) {
    return CupertinoNavigationBar(
        leading: CupertinoButton(
          padding: EdgeInsets.fromLTRB(dimens.margin, 0, 0, 0),
          child: Icon(
            Icons.arrow_back_outlined,
            color: CupertinoTheme.of(context).primaryColor,
            size: dimens.iconSizeTitle
          ),
          onPressed: () => popToMainPage
        ),
      middle: Text(
        strings.titleSetting,
        style: TextStyle(
          fontSize: dimens.fontTextTitle
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  void popToMainPage() {
    //TODO: 설정 페이지 이동
  }
}