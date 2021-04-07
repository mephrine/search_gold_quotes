import 'package:flutter/material.dart';
import 'package:search_gold_quotes/app/domain/entities/home_gold.dart';
import 'package:search_gold_quotes/core/values/dimens.dart';
import 'package:search_gold_quotes/core/extensions/string_extension.dart';

class TodayGoldPriceWidget extends StatelessWidget {
  final List<HomeGold> goldList;

  TodayGoldPriceWidget({@required this.goldList});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TodayGoldPriceItemWidget(homeGold: goldList[0]),
          TodayGoldPriceItemWidget(homeGold: goldList[1]),
          TodayGoldPriceItemWidget(homeGold: goldList[2]),
        ],
      ),
      margin: EdgeInsets.fromLTRB(
          Dimens.margin, 0, Dimens.margin, Dimens.mainTabBarCurveMargin),
    );
  }
}

class TodayGoldPriceItemWidget extends StatefulWidget {
  final HomeGold homeGold;

  TodayGoldPriceItemWidget({@required this.homeGold});

  @override
  _TodayGoldPriceItemWidgetState createState() =>
      _TodayGoldPriceItemWidgetState();
}

class _TodayGoldPriceItemWidgetState extends State<TodayGoldPriceItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Text(widget.homeGold.day,
        //     style: TextStyle(
        //         fontSize: Dimens.fontTextBig,
        //         color: Colors.redAccent,
        //         fontWeight: FontWeight.bold)),
        Text(widget.homeGold.date,
            style: TextStyle(
                fontSize: Dimens.fontTextSmall,
                color: Colors.redAccent,
                fontWeight: FontWeight.bold)),
        Text(widget.homeGold.price.toNumberFormat(),
            style: TextStyle(
                fontSize: Dimens.fontTextTitle,
                color: Theme.of(context).primaryColorDark,
                fontWeight: FontWeight.bold)),
      ],
    );
  }
}
