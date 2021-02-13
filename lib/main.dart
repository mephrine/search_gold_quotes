import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:search_gold_quotes/app/presentation/pages/intro/splash_page.dart';
import 'app/number_trivia/presentation/pages/number_trivia_page.dart';
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
    return MaterialApp(
      title: 'Search Gold Quotes',
      theme: ThemeData(
          primaryColor: Colors.blue.shade800,
          accentColor: Colors.blue.shade600),
      home: NumberTriviaPage(),
    );
  }
}
