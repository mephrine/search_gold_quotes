
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_gold_quotes/app/presentation/widgets/navigation_push_widget.dart';
import 'package:search_gold_quotes/core/theme/theme_notifier.dart';
import 'package:search_gold_quotes/core/values/strings.dart' as strings;

class VersionInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeNotifier themeService = Provider.of<ThemeNotifier>(context);
    return CupertinoApp(
      theme: themeService.getTheme(),
      home: _VersionInfoView(),
    );
  }
}

class _VersionInfoView extends StatefulWidget {
  @override
  _VersionInfoViewState createState() => _VersionInfoViewState();
}

class _VersionInfoViewState extends State<_VersionInfoView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavigationPushWidget(title: strings.titleOpenSourceLicense,),
      body: Text('VersionPage'),
    );
  }
}
