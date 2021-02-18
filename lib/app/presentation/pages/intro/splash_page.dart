import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:search_gold_quotes/core/presentation/routes/coordinator.gr.dart';

class SplashPage extends StatefulWidget {
  @override
  SplashView createState() {
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
    return  CupertinoApp(
      home: Scaffold(
          body: Container(
            child: new Center(
              child: Lottie.asset('assets/gold.json'),
            ),
          )
      ),
    );
  }
}

void _push(BuildContext context) async {
  Timer(Duration(seconds: 2), () => ExtendedNavigator.of(context).replace(Routes.mainPage));
}