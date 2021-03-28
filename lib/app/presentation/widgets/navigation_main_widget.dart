import 'package:flutter/material.dart';
import 'package:search_gold_quotes/core/values/colors.dart';
import 'package:search_gold_quotes/core/values/dimens.dart';
import 'package:search_gold_quotes/core/presentation/routes/router.gr.dart';
import 'package:auto_route/auto_route.dart';

class NavigationMainWidget extends StatelessWidget with PreferredSizeWidget {
  final String title;

  const NavigationMainWidget({Key key, @required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Theme.of(context).accentColor,
        title: Text(
          title,
          style: const TextStyle(
              color: Palette.naviTitleColor,
              fontSize: Dimens.fontTextTitle,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Palette.iconColor,
              size: Dimens.iconSizeTitle,
            ),
            onPressed: () => presentToSettingPage(context),
          )
        ]);
  }

  void presentToSettingPage(BuildContext context) {
    context.rootNavigator.push(AppRoute.settingPage);
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
