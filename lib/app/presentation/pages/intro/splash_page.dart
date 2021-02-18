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
    return CupertinoApp(
      home: Scaffold(
        body: Center(
          child: Column(
            children: <Widget>[
              Lottie.asset(
                'assets/gold.json',
                // width: 200,
                // height: 200,
                // fit: BoxFit.fill
                // controller: _controller,
                // onLoaded: (composition) {
                //   // Configure the AnimationController with the duration of the
                //   // Lottie file and start the animation.
                //   _controller
                //     ..duration = composition.duration
                //     ..forward();
                // },
              ),
              Image.asset('images/logo.png')
            ],
          ),
        ),
      ),
    );
  }
}

void _push(BuildContext context) async {
  Timer(Duration(seconds: 2),
      () => ExtendedNavigator.of(context).replace(Routes.mainPage));
}
