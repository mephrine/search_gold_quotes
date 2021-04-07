import 'package:flutter/material.dart';
import 'package:search_gold_quotes/app/presentation/style/TextStyles.dart';
import 'package:search_gold_quotes/core/values/dimens.dart';

class HistoryErrorWidget extends StatelessWidget {
  final String errorMessage;
  const HistoryErrorWidget({Key key, @required this.errorMessage})
      : super(key: key);

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
