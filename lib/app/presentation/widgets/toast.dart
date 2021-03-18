import 'package:fluttertoast/fluttertoast.dart';
import 'package:search_gold_quotes/core/values/colors.dart';

import 'package:search_gold_quotes/core/values/dimens.dart';

class ToastWidget {
  static void show(String msg) => Fluttertoast.showToast(
      msg: msg ?? "Toast message",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Palette.toastBackgroundColor,
      textColor: Palette.toastTextColor,
      fontSize: Dimens.fontText);

  static void cancelAll() => Fluttertoast.cancel();
}
