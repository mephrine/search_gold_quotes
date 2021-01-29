import 'dart:async';
import 'package:flutter/material.dart';
import 'package:search_gold_quotes/main_view.dart';

class SplashScreen extends StatefulWidget {
  @override
  Splash createState() => Splash();
}

class Splash extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    new Future.delayed(
      const Duration(seconds: 2),
            () => Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MainScreen()))
        // () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => MainScreen()))
    );
  }

  @override
  Widget build(BuildContext context) {
    var centerText = Text("스플래시 화면");

    return  MaterialApp(
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
