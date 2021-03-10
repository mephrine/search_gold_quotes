import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:search_gold_quotes/core/values/dimens.dart' as dimens;

class TextPrimaryStyles {
  final smallStyle = TextStyle(
    fontSize: dimens.fontTextSmall,
  );

  static bigStyle(BuildContext context) => TextStyle(
      fontSize: dimens.fontTextBig,
      color: CupertinoTheme.of(context).primaryColor,
      fontWeight: FontWeight.normal);

  static titleStyle(BuildContext context) => TextStyle(
      fontSize: dimens.fontTextTitle,
      color: CupertinoTheme.of(context).primaryColor,
      fontWeight: FontWeight.bold);

  static defaultStyle(BuildContext context) => TextStyle(
      fontSize: dimens.fontText,
      color: CupertinoTheme.of(context).primaryColor,
      fontWeight: FontWeight.normal);

  static smallerStyle(BuildContext context) => TextStyle(
      fontSize: dimens.fontTextSmaller,
      color: CupertinoTheme.of(context).primaryColor,
      fontWeight: FontWeight.normal);
}

class TextPrimaryContrastingStyles {
  final smallStyle = TextStyle(
    fontSize: dimens.fontTextSmall,
  );

  static bigStyle(BuildContext context) => TextStyle(
      fontSize: dimens.fontTextBig,
      color: CupertinoTheme.of(context).primaryContrastingColor,
      fontWeight: FontWeight.normal);

  static titleStyle(BuildContext context) => TextStyle(
      fontSize: dimens.fontTextTitle,
      color: CupertinoTheme.of(context).primaryContrastingColor,
      fontWeight: FontWeight.bold);

  static defaultStyle(BuildContext context) => TextStyle(
      fontSize: dimens.fontText,
      color: CupertinoTheme.of(context).primaryContrastingColor,
      fontWeight: FontWeight.normal);

  static smallerStyle(BuildContext context) => TextStyle(
      fontSize: dimens.fontTextSmaller,
      color: CupertinoTheme.of(context).primaryContrastingColor,
      fontWeight: FontWeight.normal);
}
