import 'package:intl/intl.dart';

extension IntExtenstion on int {
  String toNumberFormat() {
    final format = NumberFormat.simpleCurrency(
        locale: 'ko_KR', name: '', decimalDigits: 0);
    return format.format(this ?? 0);
  }

  String toNumberFormatCurrenyWon() => "${this.toNumberFormat()}원";
}

extension DoubleExtenstion on double {
  String toNumberFormat() {
    final format = NumberFormat.simpleCurrency(
        locale: 'ko_KR', name: '', decimalDigits: 0);
    return format.format(this ?? 0);
  }

  String toNumberFormatCurrenyWon() => "${this.toNumberFormat()}원";
}

extension StringExtension on String {
  String toNumberFormat() {
    try {
      final number = int.tryParse(this);
      final format = NumberFormat.simpleCurrency(
          locale: 'ko_KR', name: '', decimalDigits: 0);
      return format.format(number ?? 0);
    } catch (exception) {
      return this;
    }
  }

  String toNumberFormatCurrenyWon() => "${this.toNumberFormat()}원";

  String toDateFormat(String format) {
    return DateFormat(format).format(DateTime.parse(this));
  }
}
