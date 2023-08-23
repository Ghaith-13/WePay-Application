import 'package:charts_flutter/flutter.dart' as charts;

class BarChartModel {
  String Year;
  int financial;
  final charts.Color color;
  BarChartModel({
    required this.Year,
    required this.financial,
    required this.color,
  });
}
