import 'package:intl/intl.dart';

extension DoubleExtenstion on double {
  String toNumberFormat() {
    final format = NumberFormat.simpleCurrency(
        locale: 'ko_KR', name: '', decimalDigits: 0);
    return format.format(this ?? 0);
  }

  String toNumberFormatCurrenyWon() => "${this.toNumberFormat()}원";
}
