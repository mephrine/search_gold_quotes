import 'dart:convert';
import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:provider/provider.dart';
import 'package:search_gold_quotes/app/domain/entities/history_jewelry.dart';
import 'package:search_gold_quotes/app/domain/usecases/get_searched_price_history.dart';
import 'package:search_gold_quotes/app/presentation/style/TextStyles.dart';
import 'package:search_gold_quotes/app/presentation/widgets/navigation_main_scrollable_widget.dart';
import 'package:search_gold_quotes/core/di/injection_container.dart';
import 'package:search_gold_quotes/core/theme/theme_notifier.dart';
import 'package:search_gold_quotes/core/values/colors.dart';
import 'package:search_gold_quotes/core/values/dimens.dart';
import 'package:search_gold_quotes/core/values/strings.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:search_gold_quotes/core/extensions/number.dart';

import 'bloc/history_bloc.dart';

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
                // SliverToBoxAdapter(
                //   child: HistoryTabBar(),
                // )
              ];
            },
            body: Scaffold(
              appBar: HistoryTabBar(),
              body: TabBarView(children: [
                BlocProvider(
                    create: (_) => container<HistoryBloc>(),
                    child: HistoryListContainer(
                      key: PageStorageKey("gold"),
                      jewelryType: JewelryType.gold,
                    )),
                BlocProvider(
                    create: (_) => container<HistoryBloc>(),
                    child: HistoryListContainer(
                        key: PageStorageKey("platinum"),
                        jewelryType: JewelryType.platinum)),
                BlocProvider(
                    create: (_) => container<HistoryBloc>(),
                    child: HistoryListContainer(
                        key: PageStorageKey("sliver"),
                        jewelryType: JewelryType.silver)),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

class HistoryTabBar extends StatelessWidget with PreferredSizeWidget {
  const HistoryTabBar({Key key}) : super(key: key);

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

class HistoryListContainer extends StatefulWidget {
  final JewelryType jewelryType;

  HistoryListContainer({Key key, @required this.jewelryType}) : super(key: key);

  @override
  _HistoryListContainerState createState() => _HistoryListContainerState();
}

class _HistoryListContainerState extends State<HistoryListContainer>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    _dispatchInitHistoryData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryBloc, HistoryState>(builder: (bloc, state) {
      if (state is Loading) {
        return _LoadingListWidget();
      } else if (state is Loaded) {
        return HistoryListWidget(
            jewelryType: widget.jewelryType,
            period: state.period,
            exchangeState: state.exchangeState,
            historyList: state.historyList,
            chartList: state.chartList,
            sortedPriceList: state.sortedPriceList);
      } else if (state is Error) {
        return _ErrorWidget(errorMessage: state.errorMessage);
      }
    });
  }

  void _dispatchInitHistoryData() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<HistoryBloc>().add(GetSearchedHistoryList(
          period: Period.daily,
          exchangeState: ExchangeState.buy,
          jewelryType: widget.jewelryType));
    });
  }

  @override
  bool get wantKeepAlive => true;
}

class _LoadingListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
      enabled: true,
      child: ListView.separated(
        itemBuilder: (context, index) {
          if (index == 0) {
            return Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: TextButton.icon(
                      onPressed: () => null,
                      icon: Icon(
                        Icons.sort,
                        color: Theme.of(context).primaryColor,
                      ),
                      label: Text(
                          '${Period.daily.toSortTitleInScreen()}' +
                              '${ExchangeState.buy.toSortTitleInScreen()}',
                          style: TextPrimaryContrastingStyles.defaultStyle(
                              context))),
                ),
                Container(
                  width: double.infinity,
                  height: 300.0,
                  color: Colors.white,
                ),
              ],
            );
          }
          return _LoadingListItemWidget();
        },
        separatorBuilder: (context, index) => Divider(),
        itemCount: 2,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.all(Dimens.margin),
      ),
    );
  }
}

class _LoadingListItemWidget extends StatelessWidget {
  const _LoadingListItemWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child:
          Container(height: 40.0, width: double.infinity, color: Colors.white),
    );
  }
}

class HistoryListWidget extends StatelessWidget {
  final JewelryType jewelryType;
  final Period period;
  final ExchangeState exchangeState;
  final HistoryJewelryList historyList;
  final List<HistoryJewelry> chartList;
  final List<double> sortedPriceList;

  const HistoryListWidget(
      {Key key,
      @required this.jewelryType,
      @required this.period,
      @required this.exchangeState,
      @required this.historyList,
      @required this.chartList,
      @required this.sortedPriceList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        child: ListView.separated(
          itemBuilder: (context, index) {
            if (index == 0) {
              return Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: TextButton.icon(
                        onPressed: () => _onPressedSortButton(context),
                        icon: Icon(
                          Icons.sort,
                          color: Theme.of(context).primaryColor,
                        ),
                        label: Text(
                            '${period.toSortTitleInScreen()}' +
                                '${exchangeState.toSortTitleInScreen()}',
                            style: TextPrimaryContrastingStyles.defaultStyle(
                                context))),
                  ),
                  HistoryLineChart(
                      historyList: chartList,
                      sortedPriceList: sortedPriceList,
                      chartTitle: jewelryType.toSortTitleInScreen())
                ],
              );
            }

            return HistoryItemWidget(
                historyItem: historyList.historyList[index]);
          },
          separatorBuilder: (context, index) => index != 0
              ? Divider(color: Theme.of(context).primaryColor)
              : Container(
                  height: 30,
                ),
          itemCount: historyList.historyList.length,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.all(Dimens.margin),
        ),
        onRefresh: () async => _onRefresh(context));
  }

  Future<void> _onRefresh(BuildContext context) async {
    context.read<HistoryBloc>().add(RefreshSearchedHistoryList(
        exchangeState: exchangeState,
        jewelryType: jewelryType,
        period: period));
  }

  void _onPressedSortButton(BuildContext context) {
    const PickerData = '''
[
    {
        "구매": [
          "일별",
          "월별",
          "연별"
        ]
    },
    {
        "판매": [
          "일별",
          "월별",
          "연별"
        ]
    }
]
    ''';
    new Picker(
        adapter: PickerDataAdapter<String>(
            pickerdata: new JsonDecoder().convert(PickerData)),
        changeToFirst: true,
        textAlign: TextAlign.left,
        headercolor: Colors.white,
        containerColor: Colors.white,
        confirmText: Strings.confirm,
        cancelText: Strings.cancel,
        columnPadding: const EdgeInsets.all(8.0),
        onConfirm: (Picker picker, List value) {
          print(value.toString());
          print(picker.getSelectedValues());
          _dispatchInitHistoryData(context, value);
        }).showModal(context);
  }

  void _dispatchInitHistoryData(
      BuildContext context, List<int> selectedValues) {
    ExchangeState exchangeState = ExchangeState.buy;
    if (selectedValues.first == 1) {
      exchangeState = ExchangeState.sell;
    }

    Period period = Period.daily;
    if (selectedValues.last == 1) {
      period = Period.monthly;
    } else if (selectedValues.last == 2) {
      period = Period.yearly;
    }

    context.read<HistoryBloc>().add(GetSearchedHistoryList(
        period: period,
        exchangeState: exchangeState,
        jewelryType: jewelryType));
  }
}

class HistorySortWidget extends StatelessWidget {
  final JewelryType jewelryType;

  const HistorySortWidget({Key key, @required this.jewelryType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class HistoryItemWidget extends StatelessWidget {
  final HistoryJewelry historyItem;

  const HistoryItemWidget({Key key, @required this.historyItem})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      child: Row(
        children: [
          Expanded(
            child: Text(
              historyItem.date,
              style: TextPrimaryContrastingStyles.defaultStyle(context),
            ),
          ),
          Text(
            '${historyItem.price.toNumberFormatCurrenyWon()}',
            style: TextPrimaryContrastingStyles.defaultStyle(context),
          )
        ],
      ),
    );
  }
}

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
                  chartTitle,
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
              case 1:
                return historyList.first.date.toDateFormat("MM-dd");
              case 4:
                return historyList.last.date.toDateFormat("MM-dd");
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
          getTitles: (value) => '${value.toInt().toNumberFormatCurrenyWon()}'

          // if (value == maxPrice) {
          //   return '${maxPrice.toInt().toNumberFormat()} 원';
          // } else if (value == middlePrice) {
          //   return '${middlePrice.toInt().toNumberFormat()}원';
          // } else if (value == minPrice) {
          //   return '${minPrice.toInt().toNumberFormat()}원';
          // }
          // return '';
          ,
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
      maxX: 4,
      maxY: sortedPriceList.last,
      minY: sortedPriceList.first,
      lineBarsData: linesBarData(historyList
          .map((item) => (double.tryParse(item.price) ?? 0.0))
          .toList()),
    );
  }

  List<LineChartBarData> linesBarData(List<double> priceList) {
    final LineChartBarData lineChartBarData = LineChartBarData(
      spots: [
        FlSpot(0, priceList[0]),
        FlSpot(1, priceList[1]),
        FlSpot(2, priceList[2]),
        FlSpot(3, priceList[3]),
        FlSpot(4, priceList[4]),
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

class _ErrorWidget extends StatelessWidget {
  final String errorMessage;
  const _ErrorWidget({Key key, @required this.errorMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Padding(
        padding: const EdgeInsets.all(Dimens.margin),
        child: Text(
          errorMessage,
          style: TextPrimaryContrastingStyles.titleStyle(context),
        ),
      )),
    );
  }
}
