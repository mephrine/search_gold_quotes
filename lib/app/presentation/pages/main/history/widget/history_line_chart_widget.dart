import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_gold_quotes/app/domain/entities/history_jewelry.dart';
import 'package:search_gold_quotes/core/presentation/utils/chart_utils.dart';
import 'package:search_gold_quotes/core/theme/theme_notifier.dart';
import 'package:search_gold_quotes/core/values/colors.dart';
import 'package:search_gold_quotes/core/values/date_format_type.dart';
import 'package:search_gold_quotes/core/values/dimens.dart';
import 'package:search_gold_quotes/core/extensions/int_extension.dart';
import 'package:search_gold_quotes/core/extensions/string_extension.dart';

class HistoryLineChart extends StatelessWidget {
  final List<HistoryJewelry> historyList;
  final List<double> sortedPriceList;
  final String chartTitle;

  HistoryLineChart(
      {@required this.historyList,
      @required this.sortedPriceList,
      @required this.chartTitle});

  @override
  Widget build(BuildContext context) {
    ThemeNotifier themeService = Provider.of<ThemeNotifier>(context);
    return AspectRatio(
      aspectRatio: 1,
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
                  chartTitle,
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: Dimens.fontTextBigger,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        right: Dimens.margin, left: Dimens.spacing),
                    child: LineChart(
                      historyLineChartData(context),
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

  LineChartData historyLineChartData(BuildContext context) {
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
              case 2:
                return historyList.first.date
                    .toDateFormat(DateFormatType.chartBottomDateFormat);
              case 10:
                return historyList.last.date
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
            if (value == sortedPriceList.last ||
                value == sortedPriceList.first) {
              return '${value.toInt().toNumberFormatCurrenyWon()}';
            }
            return '';
          },
          margin: 12,
          reservedSize: 90,
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
      maxX: 12,
      maxY: sortedPriceList.last +
          ChartUtils.getEfficientInterval(
              sortedPriceList.last, sortedPriceList.first),
      minY: sortedPriceList.first -
          ChartUtils.getEfficientInterval(
              sortedPriceList.last, sortedPriceList.first),
      lineBarsData: linesBarData(historyList
          .map((item) => (double.tryParse(item.price) ?? 0.0))
          .toList()),
    );
  }

  int getStandardDeviation(List<double> doubles) {
    final average =
        doubles.reduce((value, element) => value + element) / doubles.length;
    final variable = doubles
            .map((number) => sqrt(pow(number - average, 2)))
            .reduce((value, element) => value + element) /
        doubles.length;
    return variable.round();
  }

  List<LineChartBarData> linesBarData(List<double> priceList) {
    final LineChartBarData lineChartBarData = LineChartBarData(
      spots: [
        FlSpot(2, priceList[0]),
        FlSpot(4, priceList[1]),
        FlSpot(6, priceList[2]),
        FlSpot(8, priceList[3]),
        FlSpot(10, priceList[4]),
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
