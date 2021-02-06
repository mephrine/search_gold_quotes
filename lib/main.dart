import 'package:flutter/material.dart';
import 'package:search_gold_quotes/features/number_trivia/presentation/pages/splash.dart';
import 'injection_container.dart' as di;

void main() async {
  await di.init();
  runApp(Main());
}

class Main extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return SplashScreen();
  }
}

