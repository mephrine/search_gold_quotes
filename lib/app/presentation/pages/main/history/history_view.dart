import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/widgets.dart';

class HistoryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(children: [
          Text("Gold is God"),
          Text("Ref."),
          LineChart(
            LineChartData(
                // read about it in the below section
                ),
          ),
        ]),
      ),
    );
  }
}
