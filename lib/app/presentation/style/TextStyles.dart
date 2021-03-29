import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:search_gold_quotes/core/values/dimens.dart';

class TextPrimaryStyles {
  final smallStyle = TextStyle(
    fontSize: Dimens.fontTextSmall,
  );

  static bigStyle(BuildContext context) => TextStyle(
      fontSize: Dimens.fontTextBig,
      color: Theme.of(context).primaryColorLight,
      fontWeight: FontWeight.normal);

  static titleStyle(BuildContext context) => TextStyle(
      fontSize: Dimens.fontTextTitle,
      color: Theme.of(context).primaryColorLight,
      fontWeight: FontWeight.bold);

  static defaultStyle(BuildContext context) => TextStyle(
      fontSize: Dimens.fontText,
      color: Theme.of(context).primaryColorLight,
      fontWeight: FontWeight.normal);

  static smallerStyle(BuildContext context) => TextStyle(
      fontSize: Dimens.fontTextSmaller,
      color: Theme.of(context).primaryColorLight,
      fontWeight: FontWeight.normal);
}

class TextPrimaryContrastingStyles {
  final smallStyle = TextStyle(
    fontSize: Dimens.fontTextSmall,
  );

  static biggerStyle(BuildContext context) => TextStyle(
      fontSize: Dimens.fontTextBigger,
      color: Theme.of(context).primaryColorDark,
      fontWeight: FontWeight.bold);

  static bigStyle(BuildContext context) => TextStyle(
      fontSize: Dimens.fontTextBig,
      color: Theme.of(context).primaryColorDark,
      fontWeight: FontWeight.normal);

  static titleStyle(BuildContext context) => TextStyle(
      fontSize: Dimens.fontTextTitle,
      color: Theme.of(context).primaryColorDark,
      fontWeight: FontWeight.bold);

  static defaultStyle(BuildContext context) => TextStyle(
      fontSize: Dimens.fontText,
      color: Theme.of(context).primaryColorDark,
      fontWeight: FontWeight.normal);

  static smallerStyle(BuildContext context) => TextStyle(
      fontSize: Dimens.fontTextSmaller,
      color: Theme.of(context).primaryColorDark,
      fontWeight: FontWeight.normal);
}
