import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_gold_quotes/app/presentation/pages/main/history/history_view.dart';
import 'package:search_gold_quotes/app/presentation/pages/main/home/home_view.dart';
import 'package:search_gold_quotes/app/presentation/pages/main/video/video_view.dart';
import 'package:search_gold_quotes/core/di/injection_container.dart';
import 'package:search_gold_quotes/core/presentation/routes/router.gr.dart';
import 'package:search_gold_quotes/core/theme/theme_notifier.dart';
import 'package:auto_route/auto_route.dart';
import 'package:search_gold_quotes/core/values/dimens.dart' as dimens;
import 'package:search_gold_quotes/core/values/strings.dart' as strings;

// StatelessWidget -> 상태가 없다! 즉, 한번 그려진 후 다시 그려지지 않는 위젯

// StatefulWidget -> 상태가 있는 위젯! 상태가 변하면 다시 그려진다!

// Cupertino -> 애플 스타일 디자인

// Material -> 구글 머터리얼 디자인

// Scaffold -> MerterialApp에서 사용ㅇ되며, AppBar, BottomNavigationBar, Drawer, FloatingActionButtion 등과 같은 많은 기본 기능을 제공.
// 즉, Material 디자인 앱의 뼈대가 되는 Widget
// Cupertino에서도 Scaffold가 사용은 가능하나, Cupertino~~로 시작하는 위젯들을 사용하면 될 듯?


class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => container<ThemeNotifier>(),
      child: Consumer<ThemeNotifier>(
          builder: (context, ThemeNotifier theme, child) {
            return CupertinoApp(
              theme: theme.getTheme(),
              home: MainView(),
            );
          }
      ),
    );
  }
}

class MainView extends StatefulWidget {
  @override
  State createState() => _MainView();
}

// class
class _MainView extends State<MainView> with SingleTickerProviderStateMixin {
  TabController _tabController;
  String _navigationTitle;
  final _tabTitleList = [strings.titleHome, strings.titleHistory, strings.titleVideo];
  final _pages = [
    HomeView(),
    HistoryView(),
    VideoView()
  ];


  @override
  void initState() {
    super.initState();
    _navigationTitle = _tabTitleList[0];
    _tabController = TabController(vsync: this, length: _tabTitleList.length);
    _tabController.addListener(changeNavigationTitleByIndex);
  }


  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavigationTitleWidget(title: _navigationTitle),
      body: TabBarView(
        controller: _tabController,
        children: _pages,
      ),
      bottomNavigationBar: ConvexAppBar(
        controller: _tabController,
        items: [
          TabItem(icon: Icons.account_balance_outlined, title: _tabTitleList[0]),
          TabItem(icon: Icons.history, title: _tabTitleList[1]),
          TabItem(icon: Icons.play_circle_outline, title: _tabTitleList[2]),
        ],
        height: dimens.bottomTabHeight,
        style: TabStyle.react,
        initialActiveIndex: 0,//optional, default as 0
        onTap: (int i) => print('click index=$i'),
        color: CupertinoTheme.of(context).primaryColor,
        backgroundColor: CupertinoTheme.of(context).barBackgroundColor,
      ),
    );
  }

  void changeNavigationTitleByIndex() {
    setState(() {
      _navigationTitle = _tabTitleList[_tabController.index];
    });
  }

  void reloadPage(int index) {

  }
}

class NavigationTitleWidget extends StatelessWidget with PreferredSizeWidget {
  final String title;

  const NavigationTitleWidget({@required this.title});

  @override
  Widget build(BuildContext context) {
    return CupertinoNavigationBar(
        trailing: CupertinoButton(
          padding: EdgeInsets.all(0),
          child: Icon(
            Icons.settings,
            color: CupertinoTheme.of(context).primaryColor,
            size: dimens.iconSizeTitle,
          ),
          onPressed: () => presentToSettingPage,
        ),
        leading: Padding(
          padding: EdgeInsets.fromLTRB(dimens.margin, 0, 0, 0),
          child: Align(
            widthFactor: 1.0,
            alignment: Alignment.center,
            child: Text(
              title,
              style: TextStyle(
                  fontSize: dimens.fontTextTitle,
                  fontWeight: FontWeight.bold,
                  color: CupertinoTheme.of(context).primaryColor),
            ),
          ),
        )
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  void presentToSettingPage(BuildContext context) {
    context.router.push(SettingPage());
  }
}