import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_gold_quotes/app/domain/entities/home_data.dart';
import 'package:search_gold_quotes/app/presentation/pages/main/home/home/home_bloc.dart';
import 'package:search_gold_quotes/app/presentation/pages/main/home/widget/famous_quotes_widget.dart';
import 'package:search_gold_quotes/app/presentation/pages/main/home/widget/home_loading_widget.dart';
import 'package:search_gold_quotes/app/presentation/pages/main/home/widget/today_gold_line_chart.dart';
import 'package:search_gold_quotes/app/presentation/pages/main/home/widget/today_gold_price_widget.dart';
import 'package:search_gold_quotes/app/presentation/widgets/message_display.dart';
import 'package:search_gold_quotes/app/presentation/widgets/navigation_main_widget.dart';
import 'package:search_gold_quotes/core/di/injection_container.dart';
import 'package:search_gold_quotes/core/values/strings.dart';

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
        return LoadingWidget();
      } else if (state is Loaded) {
        return _HomeLoadedWidget(
            homeData: state.homeData, sortedPriceList: state.sortedPriceList);
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

class _HomeLoadedWidget extends StatelessWidget {
  final HomeData homeData;
  final List<double> sortedPriceList;

  _HomeLoadedWidget({@required this.homeData, @required this.sortedPriceList});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0, left: 16.0),
      child: Column(children: [
        SizedBox(
          height: 20,
        ),
        FamousQuotesWidget(
          famousQuotes: homeData.famousSayingData.famousSaying,
          writer: homeData.famousSayingData.famousSayingWriter,
        ),
        SizedBox(
          height: 30,
        ),
        Expanded(
          child: TodayGoldLineChart(
            goldList: homeData.goldList.reversed.toList(),
            sortedPriceList: sortedPriceList,
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Positioned(
          bottom: 0.0,
          child: TodayGoldPriceWidget(
              goldList: homeData.goldList.reversed.toList()),
        ),
      ]),
    );
  }
}
