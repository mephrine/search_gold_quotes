import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:search_gold_quotes/app/domain/entities/home_data.dart';
import 'package:search_gold_quotes/app/domain/entities/home_gold.dart';
import 'package:search_gold_quotes/app/presentation/pages/main/home/home/home_bloc.dart';
import 'package:search_gold_quotes/app/presentation/style/TextStyles.dart';
import 'package:search_gold_quotes/app/presentation/widgets/message_display.dart';
import 'package:search_gold_quotes/app/presentation/widgets/navigation_main_widget.dart';
import 'package:search_gold_quotes/core/di/injection_container.dart';
import 'package:search_gold_quotes/core/theme/theme_notifier.dart';
import 'package:search_gold_quotes/core/values/colors.dart';
import 'package:search_gold_quotes/core/values/dimens.dart';
import 'package:search_gold_quotes/core/values/strings.dart';
import 'package:search_gold_quotes/core/extensions/number.dart';
import 'package:shimmer/shimmer.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => container<HomeBloc>(),
        child: Scaffold(
          appBar: NavigationMainWidget(title: Strings.titleHome),
          body: HomeContainer(),
        ));
  }
}

class HomeContainer extends StatefulWidget {
  @override
  _HomeContainer createState() => _HomeContainer();
}

class _HomeContainer extends State<HomeContainer> {
  @override
  void initState() {
    super.initState();
    _dispatchHomeData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(builder: (bloc, state) {
      if (state is Loading) {
        return _LoadingWidget();
      } else if (state is Loaded) {
        return _HomeLoadedWidget(homeData: state.homeData);
      } else if (state is Error) {
        return MessageDisplay(message: state.message);
      }
      return Container();
    });
  }

  void _dispatchHomeData() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<HomeBloc>(context, listen: false).add(GetHomeData());
    });
  }
}

class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey[300],
        highlightColor: Colors.grey[100],
        enabled: true,
        child: Padding(
          padding: const EdgeInsets.only(right: 16.0, left: 16.0),
          child: Column(children: [
            SizedBox(
              height: 20,
            ),
            Container(
              color: Colors.white,
              width: double.infinity,
              height: 20,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              color: Colors.white,
              width: double.infinity,
              height: 14,
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Positioned(
                bottom: 0.0,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                      0.0, 0.0, 0.0, Dimens.mainTabBarCurveMargin),
                  child: Container(
                    color: Colors.white,
                    width: double.infinity,
                    height: 100,
                  ),
                )),
          ]),
        ));
  }
}

class _HomeLoadedWidget extends StatelessWidget {
  final HomeData homeData;

  _HomeLoadedWidget({@required this.homeData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0, left: 16.0),
      child: Column(children: [
        SizedBox(
          height: 20,
        ),
        FamousQuotesAnimationWidget(
          famousQuotes: homeData.famousQuotes,
        ),
        SizedBox(
          height: 20,
        ),
        Text(homeData.referenceSiteName,
            style: TextPrimaryContrastingStyles.defaultStyle(context)),
        SizedBox(
          height: 30,
        ),
        Expanded(
          child: TodayGoldLineChart(goldList: homeData.goldList),
        ),
        SizedBox(
          height: 30,
        ),
        Positioned(
          bottom: 0.0,
          child: TodayGoldPriceWidget(goldList: homeData.goldList),
        ),
      ]),
    );
  }
}

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
        Text(widget.homeGold.day,
            style: TextStyle(
                fontSize: Dimens.fontTextBig,
                color: Colors.redAccent,
                fontWeight: FontWeight.bold)),
        Text(widget.homeGold.date,
            style: TextStyle(
                fontSize: Dimens.fontTextSmall,
                color: Theme.of(context).primaryColorDark,
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

class FamousQuotesAnimationWidget extends StatelessWidget {
  final String famousQuotes;

  FamousQuotesAnimationWidget({@required this.famousQuotes});

  @override
  Widget build(BuildContext context) {
    return TypewriterAnimatedTextKit(
      speed: Duration(milliseconds: 2000),
      repeatForever: true,
      text: [famousQuotes],
      textStyle: TextPrimaryContrastingStyles.titleStyle(context),
      pause: Duration(milliseconds: 1000),
      displayFullTextOnTap: false,
      stopPauseOnTap: false,
    );
  }
}

class TodayGoldLineChart extends StatefulWidget {
  final List<HomeGold> goldList;

  TodayGoldLineChart({@required this.goldList});

  @override
  State<StatefulWidget> createState() => _TodayGoldLineChartState();
}

class _TodayGoldLineChartState extends State<TodayGoldLineChart> {
  bool isShowingMainData;
  double maxPrice;
  double minPrice;
  double middlePrice;

  @override
  void initState() {
    super.initState();
    isShowingMainData = true;
    maxPrice = widget.goldList
        .map((item) => double.tryParse(item.price) ?? 0)
        .reduce((current, next) => current > next ? current : next);
    minPrice = widget.goldList
        .map((item) => double.tryParse(item.price) ?? 0)
        .reduce((current, next) => current < next ? current : next);
    middlePrice = minPrice + (maxPrice - minPrice) ~/ 2.0;
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
          // _isLightTheme()
          //             ? Palette.chartBackgroundLightColor
          //             : Palette.chartBackgroundDarkColor,
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
                  '2021',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 4,
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
                      sampleData1(),
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
          getTextStyles: (value) => TextStyle(
            color: Theme.of(context).primaryColor,
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
          getTextStyles: (value) => TextStyle(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          getTitles: (value) {
            if (value == maxPrice) {
              return '${maxPrice.toInt().toNumberFormat()} 원';
            } else if (value == middlePrice) {
              return '${middlePrice.toInt().toNumberFormat()}원';
            } else if (value == minPrice) {
              return '${minPrice.toInt().toNumberFormat()}원';
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
      maxY: maxPrice,
      minY: minPrice - 5000,
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
