import 'package:flutter/material.dart';
import 'package:search_gold_quotes/app/domain/usecases/get_searched_price_history.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class HistoryTabBarWidget extends StatelessWidget with PreferredSizeWidget {
  const HistoryTabBarWidget({Key key}) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(44);

  @override
  Widget build(BuildContext context) {
    return TabBar(
      tabs: [
        Tab(
          text: JewelryType.gold.toSortTitleInScreen(),
        ),
        Tab(
          text: JewelryType.platinum.toSortTitleInScreen(),
        ),
        Tab(
          text: JewelryType.silver.toSortTitleInScreen(),
        )
      ],
      labelColor: Theme.of(context).primaryColorDark,
      indicator: DotIndicator(
        color: Theme.of(context).primaryColorDark,
        paintingStyle: PaintingStyle.fill,
        distanceFromCenter: 16,
        radius: 3,
      ),
    );
  }
}
