
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_gold_quotes/app/presentation/widgets/navigation_push_widget.dart';
import 'package:search_gold_quotes/core/theme/theme_notifier.dart';
import 'package:search_gold_quotes/core/values/strings.dart' as strings;

class OpenSourceLicensePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeNotifier themeService = Provider.of<ThemeNotifier>(context);
    return CupertinoApp(
      theme: themeService.getTheme(),
      home: _OpenSourceLicenseView(),
    );
  }
}

class _OpenSourceLicenseView extends StatefulWidget {
  @override
  _OpenSourceLicenseViewState createState() => _OpenSourceLicenseViewState();
}

class _OpenSourceLicenseViewState extends State<_OpenSourceLicenseView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavigationPushWidget(title: strings.titleOpenSourceLicense,),
      body: Text('OpenSourceLicensePage'),
    );
  }
}
