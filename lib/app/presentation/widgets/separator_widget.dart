import 'package:flutter/material.dart';
import 'package:search_gold_quotes/core/values/dimens.dart' as dimens;

class SeparatorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      color: Colors.grey,
      padding: EdgeInsets.all(dimens.margin),
    );
  }
}