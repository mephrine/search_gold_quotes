
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:meta/meta.dart';
import 'package:search_gold_quotes/app/presentation/widgets/navigation_push_widget.dart';
import 'package:search_gold_quotes/core/theme/theme_notifier.dart';
import 'package:search_gold_quotes/core/values/strings.dart' as strings;

class VersionInfoPage extends StatelessWidget {
  final String title;

  VersionInfoPage({@required this.title});

  @override
  Widget build(BuildContext context) {
    ThemeNotifier themeService = Provider.of<ThemeNotifier>(context);
    return MaterialApp(
      theme: themeService.getTheme(),
      home: _VersionInfoView(title: title),
    );
  }
}

class _VersionInfoView extends StatefulWidget {
  final String title;

  _VersionInfoView({@required this.title});

  @override
  _VersionInfoViewState createState() => _VersionInfoViewState();
}

class _VersionInfoViewState extends State<_VersionInfoView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavigationPushWidget(title: widget.title),
      body: Text('VersionPage'),
    );
  }
}
