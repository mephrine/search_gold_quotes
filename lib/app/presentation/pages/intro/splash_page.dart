import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:search_gold_quotes/app/presentation/pages/main/main_page.dart';
import 'package:search_gold_quotes/core/platform/device_utils.dart' as device;
import 'package:search_gold_quotes/core/presentation/routes/coordinator.gr.dart';

class SplashPage extends StatefulWidget {
  @override
  SplashView createState() {
    if (device.isAndroid) {
      return SplashView();
    }
    return SplashView();
  }
}

class SplashView extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var centerText = Text("스플래시 화면");
    _push(context);

    return  CupertinoApp(
      home: Scaffold(
          body: Container(
            decoration: new BoxDecoration(color: Colors.red),
            child: new Center(
              child: centerText,
            ),
          )
      ),
    );
  }
}

class SplashMaterial extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var centerText = Text("스플래시 화면");
    _push(context);

    return  CupertinoApp(
      home: SplashContainer(centerText),
    );
  }
}

class SplashContainer extends StatelessWidget {
  final centerText;

  const SplashContainer(this.centerText);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: new BoxDecoration(color: Colors.red),
          child: new Center(
            child: centerText,
          ),
        )
    );
  }
}


void _push(BuildContext context) async {
  Timer(Duration(seconds: 2), () => ExtendedNavigator.of(context).replace(Routes.mainPage));
}