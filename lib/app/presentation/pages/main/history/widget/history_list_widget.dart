import 'package:flutter/material.dart';
import 'package:search_gold_quotes/app/domain/entities/history_jewelry.dart';
import 'package:search_gold_quotes/app/domain/usecases/get_searched_price_history.dart';
import 'package:search_gold_quotes/app/presentation/pages/main/history/bloc/history_bloc.dart';
import 'package:search_gold_quotes/app/presentation/pages/main/history/widget/history_line_chart_widget.dart';
import 'package:search_gold_quotes/app/presentation/pages/main/history/widget/history_sort_picker.dart';
import 'package:search_gold_quotes/app/presentation/style/TextStyles.dart';
import 'package:search_gold_quotes/core/values/dimens.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_gold_quotes/core/extensions/string_extension.dart';

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

            return _HistoryItemWidget(
                historyItem: historyList.historyList[index - 1]);
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
        onRefresh: () async => _onRefresh);
  }

  Future<void> _onRefresh(BuildContext context) async {
    context.read<HistoryBloc>().add(RefreshSearchedHistoryList(
        exchangeState: exchangeState,
        jewelryType: jewelryType,
        period: period));
  }

  void _onPressedSortButton(BuildContext context) {
    HistorySortPicker.makeHistoryPicker(
            (picker, value) => _dispatchInitHistoryData(context, value))
        .showModal(context);
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

class _HistoryItemWidget extends StatelessWidget {
  final HistoryJewelry historyItem;

  const _HistoryItemWidget({Key key, @required this.historyItem})
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
