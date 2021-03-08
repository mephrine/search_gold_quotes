
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:meta/meta.dart';
import 'package:search_gold_quotes/app/presentation/widgets/navigation_push_widget.dart';
import 'package:search_gold_quotes/core/theme/theme_notifier.dart';
import 'package:search_gold_quotes/core/values/strings.dart' as strings;

class OpenSourceLicensePage extends StatelessWidget {
  final String title;

  OpenSourceLicensePage({@required this.title});

  @override
  Widget build(BuildContext context) {
    ThemeNotifier themeService = Provider.of<ThemeNotifier>(context);
    return CupertinoApp(
      theme: themeService.getTheme(),
      home: _OpenSourceLicenseView(title: title),
    );
  }
}

class _OpenSourceLicenseView extends StatefulWidget {
  final String title;

  _OpenSourceLicenseView({@required this.title});

  @override
  _OpenSourceLicenseViewState createState() => _OpenSourceLicenseViewState();
}

class _OpenSourceLicenseViewState extends State<_OpenSourceLicenseView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavigationPushWidget(title: widget.title),
      body: Text('OpenSourceLicensePage'),
    );
  }
}
