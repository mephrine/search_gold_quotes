import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:search_gold_quotes/core/values/strings.dart';

class HistorySortPicker {
  static const PickerData = '''
[
    {
        "구매": [
          "일별",
          "월별",
          "연별"
        ]
    },
    {
        "판매": [
          "일별",
          "월별",
          "연별"
        ]
    }
]
    ''';
  static Picker makeHistoryPicker(
          Function(Picker picker, List value) onConfirm) =>
      Picker(
          adapter: PickerDataAdapter<String>(
              pickerdata: new JsonDecoder().convert(PickerData)),
          changeToFirst: true,
          textAlign: TextAlign.left,
          headercolor: Colors.white,
          containerColor: Colors.white,
          confirmText: Strings.confirm,
          cancelText: Strings.cancel,
          columnPadding: const EdgeInsets.all(8.0),
          onConfirm: (Picker picker, List value) {
            print(value.toString());
            print(picker.getSelectedValues());
            onConfirm(picker, value);
          });
}
