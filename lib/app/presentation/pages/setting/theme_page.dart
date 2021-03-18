import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:meta/meta.dart';
import 'package:search_gold_quotes/app/presentation/widgets/navigation_push_widget.dart';
import 'package:search_gold_quotes/core/theme/theme_notifier.dart';
import 'package:search_gold_quotes/core/values/strings.dart';

class ThemePage extends StatelessWidget {
  final String title;

  ThemePage({@required this.title});

  @override
  Widget build(BuildContext context) {
    ThemeNotifier themeService = Provider.of<ThemeNotifier>(context);
    return MaterialApp(
      theme: themeService.getTheme(),
      home: _ThemeView(title: title),
    );
  }
}

class _ThemeView extends StatefulWidget {
  final String title;

  _ThemeView({@required this.title});

  @override
  _ThemeViewState createState() => _ThemeViewState();
}

class _ThemeViewState extends State<_ThemeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavigationPushWidget(title: widget.title),
      body: Text('ThemePage'),
    );
  }
}
