import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:search_gold_quotes/app/presentation/pages/intro/splash_page.dart';
import 'package:search_gold_quotes/core/presentation/routes/coordinator.gr.dart';

import 'core/di/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();  // 비동기로 진행 시, 반드시 추가해야함.
  await di.init();
  runApp(Main());
}

class Main extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return SplashPage();
  }
}
