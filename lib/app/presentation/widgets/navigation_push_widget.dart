import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:search_gold_quotes/core/presentation/routes/router.gr.dart';
import 'package:search_gold_quotes/core/values/dimens.dart' as dimens;

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
          onPressed: () => context.router.pop()
      ),
      middle: Text(
        title,
        style: TextStyle(
            fontSize: dimens.fontTextTitle
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}