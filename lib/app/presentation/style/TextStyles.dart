import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:search_gold_quotes/core/values/dimens.dart' as dimens;

class TextPrimaryStyles {
  final smallStyle = TextStyle(
    fontSize: dimens.fontTextSmall,
  );

  static bigStyle(BuildContext context) => TextStyle(
      fontSize: dimens.fontTextBig,
      color: Theme.of(context).primaryColorLight,
      fontWeight: FontWeight.normal);

  static titleStyle(BuildContext context) => TextStyle(
      fontSize: dimens.fontTextTitle,
      color: Theme.of(context).primaryColorLight,
      fontWeight: FontWeight.bold);

  static defaultStyle(BuildContext context) => TextStyle(
      fontSize: dimens.fontText,
      color: Theme.of(context).primaryColorLight,
      fontWeight: FontWeight.normal);

  static smallerStyle(BuildContext context) => TextStyle(
      fontSize: dimens.fontTextSmaller,
      color: Theme.of(context).primaryColorLight,
      fontWeight: FontWeight.normal);
}

class TextPrimaryContrastingStyles {
  final smallStyle = TextStyle(
    fontSize: dimens.fontTextSmall,
  );

  static bigStyle(BuildContext context) => TextStyle(
      fontSize: dimens.fontTextBig,
      color: Theme.of(context).primaryColorDark,
      fontWeight: FontWeight.normal);

  static titleStyle(BuildContext context) => TextStyle(
      fontSize: dimens.fontTextTitle,
      color: Theme.of(context).primaryColorDark,
      fontWeight: FontWeight.bold);

  static defaultStyle(BuildContext context) => TextStyle(
      fontSize: dimens.fontText,
      color: Theme.of(context).primaryColorDark,
      fontWeight: FontWeight.normal);

  static smallerStyle(BuildContext context) => TextStyle(
      fontSize: dimens.fontTextSmaller,
      color: Theme.of(context).primaryColorDark,
      fontWeight: FontWeight.normal);
}
