import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:search_gold_quotes/app/domain/entities/history_jewelry.dart';
import 'package:search_gold_quotes/app/domain/entities/home_gold.dart';
import 'package:search_gold_quotes/app/domain/usecases/get_searched_price_history.dart';
import 'package:search_gold_quotes/app/presentation/style/TextStyles.dart';
import 'package:search_gold_quotes/app/presentation/widgets/navigation_main_scrollable_widget.dart';
import 'package:search_gold_quotes/core/di/injection_container.dart';
import 'package:search_gold_quotes/core/values/colors.dart';
import 'package:search_gold_quotes/core/values/dimens.dart';
import 'package:search_gold_quotes/core/values/strings.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import 'bloc/history_bloc.dart';

class HistoryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => container<HistoryBloc>(),
      child: DefaultTabController(
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
                    HistoryListContainer(
                      jewelryType: JewelryType.gold,
                    ),
                    HistoryListContainer(jewelryType: JewelryType.platinum),
                    HistoryListContainer(jewelryType: JewelryType.diamond),
                  ]),
                ),
              ),
            ),
          )),
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
          text: JewelryType.diamond.toSortTitleInScreen(),
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

class _HistoryListContainerState extends State<HistoryListContainer> {
  @override
  void initState() {
    super.initState();
    _dispatchInitHistoryData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryBloc, HistoryState>(builder: (bloc, state) {
      if (state is Loading) {
      } else if (state is Loaded) {
        return HistoryListWidget(
            jewelryType: widget.jewelryType,
            period: state.period,
            exchangeState: state.exchangeState,
            historyList: state.historyList);
      } else if (state is Error) {}
      return Container();
    });
  }

  void _dispatchInitHistoryData() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<HistoryBloc>(context, listen: false).add(
          GetSearchedHistoryList(
              period: Period.daily,
              exchangeState: ExchangeState.buy,
              jewelryType: widget.jewelryType));
    });
  }
}

class HistoryListWidget extends StatelessWidget {
  final JewelryType jewelryType;
  final Period period;
  final ExchangeState exchangeState;
  final HistoryJewelryList historyList;

  const HistoryListWidget(
      {Key key,
      @required this.jewelryType,
      @required this.period,
      @required this.exchangeState,
      @required this.historyList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        if (index == 0) {
          return Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                    onPressed: () => onPressedSortButton(context),
                    icon: Icon(
                      Icons.sort,
                      color: Theme.of(context).primaryColor,
                    ),
                    label: Text(
                        '${period.toSortTitleInScreen()}' +
                            '${exchangeState.toSortTitleInScreen()}',
                        style: TextPrimaryStyles.defaultStyle(context))),
              ),
              HistoryLineChart(historyList: historyList.historyList)
            ],
          );
        }

        return HistoryItemWidget(historyItem: historyList.historyList[index]);
      },
      separatorBuilder: (context, index) => Divider(),
      itemCount: historyList.historyList.length,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.all(Dimens.margin),
    );
  }

  void onPressedSortButton(BuildContext context) {
    const PickerData = '''
[
    {
        "a": [
            {
                "a1": [
                    1,
                    2,
                    3,
                    4
                ]
            },
            {
                "a2": [
                    5,
                    6,
                    7,
                    8
                ]
            },
            {
                "a3": [
                    9,
                    10,
                    11,
                    12
                ]
            }
        ]
    },
    {
        "b": [
            {
                "b1": [
                    11,
                    22,
                    33,
                    44
                ]
            },
            {
                "b2": [
                    55,
                    66,
                    77,
                    88
                ]
            },
            {
                "b3": [
                    99,
                    1010,
                    1111,
                    1212
                ]
            }
        ]
    },
    {
        "c": [
            {
                "c1": [
                    "a",
                    "b",
                    "c"
                ]
            },
            {
                "c2": [
                    "aa",
                    "bb",
                    "cc"
                ]
            },
            {
                "c3": [
                    "aaa",
                    "bbb",
                    "ccc"
                ]
            }
        ]
    }
]
    ''';
    new Picker(
        adapter: PickerDataAdapter<String>(
            pickerdata: new JsonDecoder().convert(PickerData)),
        changeToFirst: true,
        textAlign: TextAlign.left,
        columnPadding: const EdgeInsets.all(8.0),
        onConfirm: (Picker picker, List value) {
          print(value.toString());
          print(picker.getSelectedValues());
        }).showModal(context);
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
      child: Row(
        children: [
          Expanded(
            child: Text(
              historyItem.date,
              style: TextPrimaryStyles.defaultStyle(context),
            ),
          ),
          Text(
            '${historyItem.price}',
            style: TextPrimaryStyles.defaultStyle(context),
          )
        ],
      ),
    );
  }
}

class HistoryLineChart extends StatefulWidget {
  final List<HistoryJewelry> historyList;

  HistoryLineChart({@required this.historyList});

  @override
  State<StatefulWidget> createState() => _HistoryLineChartState();
}

class _HistoryLineChartState extends State<HistoryLineChart> {
  bool isShowingMainData;
  int maxPrice;
  int minPrice;
  int middlePrice;

  @override
  void initState() {
    super.initState();
    isShowingMainData = true;
    maxPrice = widget.historyList
        .map((item) => int.tryParse(item.price) ?? 0)
        .reduce((current, next) => current > next ? current : next);
    minPrice = widget.historyList
        .map((item) => int.tryParse(item.price) ?? 0)
        .reduce((current, next) => current < next ? current : next);
    middlePrice = minPrice + (maxPrice - minPrice) ~/ 2;
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.23,
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(18)),
          gradient: LinearGradient(
            colors: [
              Color(0xff2c274c),
              Color(0xff46426c),
            ],
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
                const Text(
                  '2021',
                  style: TextStyle(
                    color: Color(0xff827daa),
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 4,
                ),
                const Text(
                  '오늘의 시세',
                  style: TextStyle(
                      color: Colors.white,
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
                      isShowingMainData ? sampleData1() : sampleData2(),
                      swapAnimationDuration: const Duration(milliseconds: 250),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
            IconButton(
              icon: Icon(
                Icons.refresh,
                color: Colors.white.withOpacity(isShowingMainData ? 1.0 : 0.5),
              ),
              onPressed: () {
                setState(() {
                  isShowingMainData = !isShowingMainData;
                });
              },
            )
          ],
        ),
      ),
    );
  }

  LineChartData sampleData1() {
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
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff72719b),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          margin: 10,
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '오늘';
              case 7:
                return '어제';
              case 13:
                return '그제';
            }
            return '';
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff75729e),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '$maxPrice 원';
              case 2:
                return '$middlePrice 원';
              case 3:
                return '$minPrice 원';
            }
            return '';
          },
          margin: 8,
          reservedSize: 80,
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(
            color: Color(0xff4e4965),
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
      maxY: 220000,
      minY: 0,
      lineBarsData: linesBarData(widget.historyList
          .map((item) => double.tryParse(item.price) ?? 0.0)
          .toList()),
    );
  }

  List<LineChartBarData> linesBarData(List<double> priceList) {
    final LineChartBarData lineChartBarData1 = LineChartBarData(
      spots: [
        FlSpot(1, priceList[0]),
        FlSpot(7, priceList[1]),
        FlSpot(13, priceList[2]),
      ],
      isCurved: true,
      colors: [
        const Color(0xff4af699),
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
    final LineChartBarData lineChartBarData2 = LineChartBarData(
      spots: [
        FlSpot(1, 190000),
        FlSpot(7, 200000),
        FlSpot(13, 210000),
      ],
      isCurved: true,
      colors: [
        const Color(0xffaa4cfc),
      ],
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(show: false, colors: [
        const Color(0x00aa4cfc),
      ]),
    );
    final LineChartBarData lineChartBarData3 = LineChartBarData(
      spots: [
        FlSpot(1, 280000),
        FlSpot(7, 150000),
        FlSpot(13, 230000),
      ],
      isCurved: true,
      colors: const [
        Color(0xff27b6fc),
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
    return [
      lineChartBarData1,
      lineChartBarData2,
      lineChartBarData3,
    ];
  }

  LineChartData sampleData2() {
    return LineChartData(
      lineTouchData: LineTouchData(
        enabled: false,
      ),
      gridData: FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff72719b),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          margin: 10,
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return 'SEPT';
              case 7:
                return 'OCT';
              case 12:
                return 'DEC';
            }
            return '';
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff75729e),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '1m';
              case 2:
                return '2m';
              case 3:
                return '3m';
              case 4:
                return '5m';
              case 5:
                return '6m';
            }
            return '';
          },
          margin: 8,
          reservedSize: 30,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: const Border(
            bottom: BorderSide(
              color: Color(0xff4e4965),
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
          )),
      minX: 0,
      maxX: 14,
      maxY: 6,
      minY: 0,
      lineBarsData: linesBarData2(),
    );
  }

  List<LineChartBarData> linesBarData2() {
    return [
      LineChartBarData(
        spots: [
          FlSpot(1, 1),
          FlSpot(3, 4),
          FlSpot(5, 1.8),
          FlSpot(7, 5),
          FlSpot(10, 2),
          FlSpot(12, 2.2),
          FlSpot(13, 1.8),
        ],
        isCurved: true,
        curveSmoothness: 0,
        colors: const [
          Color(0x444af699),
        ],
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
        belowBarData: BarAreaData(
          show: false,
        ),
      ),
      LineChartBarData(
        spots: [
          FlSpot(1, 1),
          FlSpot(3, 2.8),
          FlSpot(7, 1.2),
          FlSpot(10, 2.8),
          FlSpot(12, 2.6),
          FlSpot(13, 3.9),
        ],
        isCurved: true,
        colors: const [
          Color(0x99aa4cfc),
        ],
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
        belowBarData: BarAreaData(show: true, colors: [
          const Color(0x33aa4cfc),
        ]),
      ),
      LineChartBarData(
        spots: [
          FlSpot(1, 3.8),
          FlSpot(3, 1.9),
          FlSpot(6, 5),
          FlSpot(10, 3.3),
          FlSpot(13, 4.5),
        ],
        isCurved: true,
        curveSmoothness: 0,
        colors: const [
          Color(0x4427b6fc),
        ],
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(show: true),
        belowBarData: BarAreaData(
          show: false,
        ),
      ),
    ];
  }
}
