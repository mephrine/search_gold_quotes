import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:search_gold_quotes/app/presentation/pages/main/main_page.dart';
import 'package:search_gold_quotes/core/platform/device_utils.dart' as device;

class SplashScreen extends StatefulWidget {
  @override
  SplashView createState() {
    if (device.isAndroid) {
      return SplashView();
    }
    return SplashView();
  }
}

class SplashView extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    new Future.delayed(
        const Duration(seconds: 2),
            () => Navigator.pushReplacement(context, CupertinoPageRoute<void>(builder: (BuildContext context) => MainScreen()))
      // () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => MainScreen()))
    );
  }

  @override
  Widget build(BuildContext context) {
    var centerText = Text("스플래시 화면");

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

class SplashMaterial extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    new Future.delayed(
        const Duration(seconds: 2),
            () => Navigator.pushReplacement(context, CupertinoPageRoute<void>(builder: (BuildContext context) => MainScreen()))
      // () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => MainScreen()))
    );
  }

  @override
  Widget build(BuildContext context) {
    var centerText = Text("스플래시 화면");

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
