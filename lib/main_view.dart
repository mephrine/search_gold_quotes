import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:english_words/english_words.dart';

// StatelessWidget -> 상태가 없다! 즉, 한번 그려진 후 다시 그려지지 않는 위젯

// StatefulWidget -> 상태가 있는 위젯! 상태가 변하면 다시 그려진다!

// Cupertino -> 애플 스타일 디자인

// Material -> 구글 머터리얼 디자인

// Scaffold -> MerterialApp에서 사용ㅇ되며, AppBar, BottomNavigationBar, Drawer, FloatingActionButtion 등과 같은 많은 기본 기능을 제공.
// 즉, Material 디자인 앱의 뼈대가 되는 Widget
// Cupertino에서도 Scaffold가 사용은 가능하나, Cupertino~~로 시작하는 위젯들을 사용하면 될 듯?

bool get isAndroid =>
    foundation.defaultTargetPlatform == foundation.TargetPlatform.android;

class MainScreen extends StatelessWidget {
  final String title = "Find Gold Gold!!!";

  @override
  Widget build(BuildContext context) {
    if (isAndroid)
      return MaterialMain(title);
    else
      return CupertinoMain(title);
  }
}

class MaterialMain extends StatelessWidget {
  final String title;

  const MaterialMain(this.title);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainContainer(title: this.title),
    );
  }
}

class CupertinoMain extends StatelessWidget {
  final String title;

  const CupertinoMain(this.title);

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      theme: CupertinoThemeData(
          primaryColor: Colors.white,
          scaffoldBackgroundColor: CupertinoColors.darkBackgroundGray),
      home: MainContainer(title: this.title),
    );
  }
}

class NavigationBar extends StatelessWidget with PreferredSizeWidget {
  final String title;

  const NavigationBar({@required this.title});

  @override
  Widget build(BuildContext context) {
    if (isAndroid)
      return AppBar(title: Text(title));
    else
      return CupertinoNavigationBar(
          middle: Text(title),
          leading: Align(
            widthFactor: 1.0,
            alignment: Alignment.center,
            child: NavigationButton("메뉴"),
          ));
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class NavigationButton extends StatelessWidget {
  final String buttonText;

  const NavigationButton(this.buttonText);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
        padding: EdgeInsets.all(0.0),
        child: Text(this.buttonText),
        onPressed: () => {});
  }
}

class MainTabBar extends StatelessWidget {
  final String title;
  final Color color;

  const MainTabBar({@required this.title, @required this.color});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// class
class MainContainerState extends State<MainContainer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavigationBar(title: this.widget.title),
      body: _buildSuggestions(),
    );
  }

// Dart언어에서는 식별자 앞에 _를 붙이면 private이 됨.
  final _suggestion = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, index) {
          if (index.isOdd) return Divider();

          final _splitIndex = index ~/ 2;
          if (_splitIndex >= _suggestion.length)
            _suggestion.addAll(generateWordPairs().take(10));
          return _buildRow(_suggestion[_splitIndex]);
        });
  }

  Widget _buildRow(WordPair wordPair) {
    return ListTile(
      title: Text(
        wordPair.asPascalCase,
        style: _biggerFont,
      ),
    );
  }
}

class MainContainer extends StatefulWidget {
  final String title;

  const MainContainer({@required this.title});

  @override
  State createState() => MainContainerState();
}

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);
//
// // This widget is the home page of your application. It is stateful, meaning
// // that it has a State object (defined below) that contains fields that affect
// // how it looks.
//
// // This class is the configuration for the state. It holds the values (in this
// // case the title) provided by the parent (in this case the App widget) and
// // used by the build method of the State. Fields in a Widget subclass are
// // always marked "final".
//
//   final String title;
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//
//   void _incrementCounter() {
//     setState(() {
// // This call to setState tells the Flutter framework that something has
// // changed in this State, which causes it to rerun the build method below
// // so that the display can reflect the updated values. If we changed
// // _counter without calling setState(), then the build method would not be
// // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
// // This method is rerun every time setState is called, for instance as done
// // by the _incrementCounter method above.
// //
// // The Flutter framework has been optimized to make rerunning build methods
// // fast, so that you can just rebuild anything that needs updating rather
// // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
// // Here we take the value from the MyHomePage object that was created by
// // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
// // Center is a layout widget. It takes a single child and positions it
// // in the middle of the parent.
//         child: Column(
// // Column is also a layout widget. It takes a list of children and
// // arranges them vertically. By default, it sizes itself to fit its
// // children horizontally, and tries to be as tall as its parent.
// //
// // Invoke "debug painting" (press "p" in the console, choose the
// // "Toggle Debug Paint" action from the Flutter Inspector in Android
// // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
// // to see the wireframe for each widget.
// //
// // Column has various properties to control how it sizes itself and
// // how it positions its children. Here we use mainAxisAlignment to
// // center the children vertically; the main axis here is the vertical
// // axis because Columns are vertical (the cross axis would be
// // horizontal).
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             MainContainer(title: null),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headline4,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
