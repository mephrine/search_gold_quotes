
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:meta/meta.dart';
import 'package:search_gold_quotes/app/presentation/widgets/navigation_push_widget.dart';
import 'package:search_gold_quotes/core/theme/theme_notifier.dart';
import 'package:search_gold_quotes/core/values/strings.dart' as strings;
import 'package:webview_flutter/webview_flutter.dart';

class OpenSourceLicensePage extends StatelessWidget {
  final String title;

  OpenSourceLicensePage({@required this.title});

  @override
  Widget build(BuildContext context) {
    ThemeNotifier themeService = Provider.of<ThemeNotifier>(context);
    return MaterialApp(
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
  WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavigationPushWidget(title: widget.title),
      body: WebView(
        onWebViewCreated: (WebViewController webViewController) async {
          _controller = webViewController;
          await _loadHtmlFromAssets('assets/open_source.html', _controller);
        },
      ),
    );
  }

  Future<void> _loadHtmlFromAssets(String filename, controller) async {
    String fileText = await rootBundle.loadString(filename);
    controller.loadUrl(Uri.dataFromString(fileText, mimeType: 'text/html', encoding: Encoding.getByName('utf-8')).toString());
  }
}
