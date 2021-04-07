import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:search_gold_quotes/app/domain/usecases/get_searched_price_history.dart';
import 'package:search_gold_quotes/app/presentation/pages/main/history/widget/history_list_container_widget.dart';
import 'package:search_gold_quotes/app/presentation/pages/main/history/widget/history_tab_bar_widget.dart';
import 'package:search_gold_quotes/app/presentation/widgets/navigation_main_scrollable_widget.dart';
import 'package:search_gold_quotes/core/values/strings.dart';

class HistoryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Container(
        color: Theme.of(context).accentColor,
        child: SafeArea(
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                NavigationMainScrollableWidget(title: Strings.titleHistory),
              ];
            },
            body: Scaffold(
              appBar: HistoryTabBarWidget(),
              body: TabBarView(children: [
                HistoryListContainerWidget(
                  jewelryType: JewelryType.gold,
                  key: PageStorageKey("gold"),
                ),
                HistoryListContainerWidget(
                  jewelryType: JewelryType.platinum,
                  key: PageStorageKey("platinum"),
                ),
                HistoryListContainerWidget(
                  jewelryType: JewelryType.silver,
                  key: PageStorageKey("sliver"),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
