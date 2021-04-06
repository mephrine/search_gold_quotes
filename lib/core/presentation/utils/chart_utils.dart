import 'dart:math';

class ChartUtils {
  static double getEfficientInterval(double maxPrice, double minPrice) {
    final diff = maxPrice - minPrice;
    final interval = _roundInterval(diff).toDouble();
    return interval;
  }

  static int _roundInterval(double input) {
    var count = 0;

    if (input >= 10) {
      count++;
    }

    while (input ~/ 100 != 0) {
      input /= 10;
      count++;
    }

    final scaled = input >= 10 ? input.round() / 10 : input;

    if (scaled >= 2.6) {
      return 5 * pow(10, count);
    } else if (scaled >= 1.6) {
      return 2 * pow(10, count);
    } else {
      return pow(10, count);
    }
  }
}
