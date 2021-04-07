import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_gold_quotes/app/domain/entities/home_gold.dart';
import 'package:search_gold_quotes/core/presentation/utils/chart_utils.dart';
import 'package:search_gold_quotes/core/theme/theme_notifier.dart';
import 'package:search_gold_quotes/core/values/colors.dart';
import 'package:search_gold_quotes/core/values/date_format_type.dart';
import 'package:search_gold_quotes/core/values/dimens.dart';
import 'package:search_gold_quotes/core/extensions/string_extension.dart';
import 'package:search_gold_quotes/core/extensions/int_extension.dart';

class TodayGoldLineChart extends StatefulWidget {
  final List<HomeGold> goldList;
  final List<double> sortedPriceList;

  TodayGoldLineChart({@required this.goldList, @required this.sortedPriceList});

  @override
  State<StatefulWidget> createState() => _TodayGoldLineChartState();
}

class _TodayGoldLineChartState extends State<TodayGoldLineChart> {
  bool isShowingMainData;

  @override
  void initState() {
    super.initState();
    isShowingMainData = true;
  }

  @override
  Widget build(BuildContext context) {
    ThemeNotifier themeService = Provider.of<ThemeNotifier>(context);
    return AspectRatio(
      aspectRatio: 1.23,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(18)),
          gradient: LinearGradient(
            colors: (themeService.getThemeIsDark() ?? false)
                ? Palette.chartBackgroundDarkColor
                : Palette.chartBackgroundLightColor,
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(
                  height: 37,
                ),
                Text(
                  '오늘의 시세',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 37,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        right: Dimens.margin, left: Dimens.spacing),
                    child: LineChart(
                      mainChartData(),
                      swapAnimationDuration: const Duration(milliseconds: 250),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  LineChartData mainChartData() {
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
        touchCallback: (LineTouchResponse touchResponse) {},
        handleBuiltInTouches: true,
      ),
      gridData: FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) => TextStyle(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          margin: 10,
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return widget.goldList[0].date
                    .toDateFormat(DateFormatType.chartBottomDateFormat);
              case 7:
                return widget.goldList[1].date
                    .toDateFormat(DateFormatType.chartBottomDateFormat);
              case 13:
                return widget.goldList[2].date
                    .toDateFormat(DateFormatType.chartBottomDateFormat);
            }
            return '';
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => TextStyle(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          getTitles: (value) {
            if (value == widget.sortedPriceList[0]) {
              return '${widget.sortedPriceList[0].toInt().toNumberFormatCurrenyWon()}';
            } else if (value == widget.sortedPriceList[1]) {
              return '${widget.sortedPriceList[1].toInt().toNumberFormatCurrenyWon()}';
            } else if (value == widget.sortedPriceList[2]) {
              return '${widget.sortedPriceList[2].toInt().toNumberFormatCurrenyWon()}';
            }
            return '';
          },
          margin: 8,
          reservedSize: 80,
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 4,
          ),
          left: BorderSide(
            color: Colors.transparent,
          ),
          right: BorderSide(
            color: Colors.transparent,
          ),
          top: BorderSide(
            color: Colors.transparent,
          ),
        ),
      ),
      minX: 0,
      maxX: 14,
      maxY: widget.sortedPriceList.last,
      minY: widget.sortedPriceList.first -
          ChartUtils.getEfficientInterval(
              widget.sortedPriceList.last, widget.sortedPriceList.first),
      lineBarsData: linesBarData(widget.goldList
          .map((item) => (double.tryParse(item.price) ?? 0.0))
          .toList()),
    );
  }

  List<LineChartBarData> linesBarData(List<double> priceList) {
    final LineChartBarData lineChartBarData = LineChartBarData(
      spots: [
        FlSpot(1, priceList[0]),
        FlSpot(7, priceList[1]),
        FlSpot(13, priceList[2]),
      ],
      isCurved: true,
      colors: [
        Colors.redAccent,
      ],
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: false,
      ),
    );
    return [lineChartBarData];
  }
}
