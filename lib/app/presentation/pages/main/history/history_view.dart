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
import 'package:search_gold_quotes/app/presentation/pages/main/history/widget/history_list_container_widget.dart';
import 'package:search_gold_quotes/app/presentation/pages/main/history/widget/history_tab_bar_widget.dart';
import 'package:search_gold_quotes/app/presentation/style/TextStyles.dart';
import 'package:search_gold_quotes/app/presentation/widgets/navigation_main_scrollable_widget.dart';
import 'package:search_gold_quotes/core/di/injection_container.dart';
import 'package:search_gold_quotes/core/presentation/utils/chart_utils.dart';
import 'package:search_gold_quotes/core/theme/theme_notifier.dart';
import 'package:search_gold_quotes/core/values/colors.dart';
import 'package:search_gold_quotes/core/values/date_format_type.dart';
import 'package:search_gold_quotes/core/values/dimens.dart';
import 'package:search_gold_quotes/core/values/strings.dart';
import 'package:search_gold_quotes/core/extensions/int_extension.dart';

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
              ];
            },
            body: Scaffold(
              appBar: HistoryTabBarWidget(),
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
