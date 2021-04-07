import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_gold_quotes/app/domain/usecases/get_searched_price_history.dart';
import 'package:search_gold_quotes/app/presentation/pages/main/history/bloc/history_bloc.dart';
import 'package:search_gold_quotes/app/presentation/pages/main/history/widget/history_error_widget.dart';
import 'package:search_gold_quotes/app/presentation/pages/main/history/widget/history_list_loading_widget.dart';
import 'package:search_gold_quotes/app/presentation/pages/main/history/widget/history_list_widget.dart';
import 'package:search_gold_quotes/core/di/injection_container.dart';

class HistoryListContainerWidget extends StatelessWidget {
  final JewelryType jewelryType;
  const HistoryListContainerWidget({Key key, @required this.jewelryType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => container<HistoryBloc>(),
        child: HistoryListContainer(
          key: key,
          jewelryType: jewelryType,
        ));
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
        return HistoryListLoadingWidget();
      } else if (state is Loaded) {
        return HistoryListWidget(
            jewelryType: widget.jewelryType,
            period: state.period,
            exchangeState: state.exchangeState,
            historyList: state.historyList,
            chartList: state.chartList.reversed.toList(),
            sortedPriceList: state.sortedPriceList);
      } else if (state is Error) {
        return HistoryErrorWidget(errorMessage: state.errorMessage);
      }
      return Container();
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
