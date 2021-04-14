import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_gold_quotes/app/presentation/pages/main/history/history_view.dart';
import 'package:search_gold_quotes/app/presentation/pages/main/home/home_view.dart';
import 'package:search_gold_quotes/app/presentation/pages/main/video/video_view.dart';
import 'package:search_gold_quotes/core/theme/theme_notifier.dart';
import 'package:search_gold_quotes/core/values/dimens.dart';
import 'package:search_gold_quotes/core/values/strings.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeNotifier themeService = Provider.of<ThemeNotifier>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeService.getTheme(),
      home: MainView(),
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

  final _tabTitleList = [
    Strings.titleHome,
    Strings.titleHistory,
    Strings.titleVideo
  ];
  final _pages = [HomeView(), HistoryView(), VideoView()];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: _tabTitleList.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(children: _pages, index: _tabController.index),
      bottomNavigationBar: ConvexAppBar(
        controller: _tabController,
        items: [
          TabItem(
              icon: Icons.account_balance_outlined, title: _tabTitleList[0]),
          TabItem(icon: Icons.history, title: _tabTitleList[1]),
          TabItem(icon: Icons.play_circle_outline, title: _tabTitleList[2]),
        ],
        height: Dimens.bottomTabHeight,
        style: TabStyle.react,
        initialActiveIndex: 0,
        onTap: (int i) => changeIndex(i),
        color: Theme.of(context).primaryColor,
        activeColor: Theme.of(context).primaryColor,
        backgroundColor: Theme.of(context).bottomAppBarColor,
      ),
    );
  }

  void changeIndex(int index) {
    setState(() {
      _tabController.index = index;
    });
  }
}
