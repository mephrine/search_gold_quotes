import 'package:flutter/material.dart';
import 'package:search_gold_quotes/app/domain/usecases/get_searched_price_history.dart';
import 'package:search_gold_quotes/app/presentation/style/TextStyles.dart';
import 'package:search_gold_quotes/core/values/dimens.dart';
import 'package:shimmer/shimmer.dart';

class HistoryListLoadingWidget extends StatelessWidget {
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
