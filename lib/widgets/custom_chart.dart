import 'package:ddofinance/theme/color_constants.dart';
import 'package:ddofinance/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class CustomChart extends StatelessWidget {
  const CustomChart({super.key});

  @override
  Widget build(BuildContext context) {
    MediaQueryData mQ = MediaQuery.of(context);
    double deviceWidth = mQ.size.width;
    double deviceHeight = mQ.size.height;
    final theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final ColorScheme colorTheme = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorTheme.secondary,
        borderRadius: BorderRadius.circular(Insets.s08),
        boxShadow: [
          BoxShadow(
              blurRadius: Insets.s10,
              color: const Color.fromRGBO(0, 0, 0, 0.08))
        ],
      ),
      height: deviceHeight / 1.60,
      width: deviceWidth / 1.7,
      padding: EdgeInsets.symmetric(
          vertical: deviceHeight / 30, horizontal: deviceWidth / 26.66),
      child: FittedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'FORECASTED REVENUE VS ACTUAL REVENUE',
              style: textTheme.bodyMedium?.copyWith(
                  color: colorTheme.onSecondary,
                  fontWeight: FontWeight.w800,
                  fontSize: deviceWidth / 100),
            ),
            SizedBox(
              height: deviceHeight / 51.66,
            ),
            Container(
                constraints: BoxConstraints.tightFor(
                    width: deviceWidth / 1.94, height: deviceHeight / 2.15),

                //To render the line chart based on the device width and height
                child: LineChartSample(
                  deviceWidth: deviceWidth,
                  deviceHeight: deviceHeight,
                )),
            SizedBox(
              height: deviceHeight / 51.66,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Forecasted Revenue',
                  style: textTheme.bodyMedium?.copyWith(
                      color: colorTheme.onSurface, fontSize: deviceWidth / 100),
                ),
                SizedBox(
                  width: deviceWidth / 80,
                ),
                Text(
                  'Actual Revenue',
                  style: textTheme.bodyMedium?.copyWith(
                      color: colorTheme.onSurface, fontSize: deviceWidth / 100),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class LineChartSample extends StatelessWidget {
  final double deviceWidth;
  final double deviceHeight;
  const LineChartSample(
      {super.key, required this.deviceWidth, required this.deviceHeight});

  @override
  Widget build(BuildContext context) {
    return LineChart(sampleData1);
  }

  LineChartData get sampleData1 => LineChartData(
        gridData: gridData,
        titlesData: titlesData,
        borderData: borderData,
        lineBarsData: lineBarsData,
        minX: 0,
        maxX: 5,
        minY: 0,
        maxY: 70000,
      );

  List<LineChartBarData> get lineBarsData =>
      [lineChartBarData1, lineChartBarData2];

  FlTitlesData get titlesData => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );

  //To render the left titles of the chart
  Widget leftTitlesWidget(
      double value, TitleMeta meta, double deviceWidth, double deviceHeight) {
    var style = TextStyle(
      fontWeight: FontWeight.w100,
      fontSize: deviceWidth / 100,
      color: kGreyShade1,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = '0';
        break;
      case 10000:
        text = '10,000';
        break;
      case 20000:
        text = '20,000';
        break;
      case 30000:
        text = '30,000';
        break;
      case 40000:
        text = '40,000';
        break;
      case 50000:
        text = '50,000';
        break;
      case 60000:
        text = '60,000';
        break;
      case 70000:
        text = '70,000';
        break;
      default:
        return Container();
    }
    return Text(text, style: style, textAlign: TextAlign.center);
  }

  SideTitles leftTitles() => SideTitles(
        getTitlesWidget: (value, meta) =>
            leftTitlesWidget(value, meta, deviceWidth, deviceHeight),
        showTitles: true,
        interval: 10000,
        reservedSize: deviceWidth / 22.9,
      );

  //To render the bottom titles of the chart
  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    var style = TextStyle(
      fontWeight: FontWeight.w100,
      fontSize: deviceWidth / 100,
      color: kGreyShade1,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = Text('Apr', style: style);
        break;
      case 1:
        text = Text('May', style: style);
        break;
      case 2:
        text = Text('Jun', style: style);
        break;
      case 3:
        text = Text('Jul', style: style);
        break;
      case 4:
        text = Text('Aug', style: style);
        break;
      case 5:
        text = Text('Sep', style: style);
        break;
      default:
        text = const Text('');
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: deviceWidth / 160,
      child: text,
    );
  }

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: deviceHeight / 15.5,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );

  FlGridData get gridData => const FlGridData(
        show: true,
      );

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  LineChartBarData get lineChartBarData1 => LineChartBarData(
          isCurved: false,
          color: kGreen,
          isStrokeCapRound: true,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(show: false),

          //The spots on which the line will be formed
          spots: const [
            FlSpot(0, 0),
            FlSpot(1, 6000),
            FlSpot(2, 10000),
            FlSpot(3, 15000),
            FlSpot(4, 13000),
            FlSpot(5, 20000),
          ]);

  LineChartBarData get lineChartBarData2 => LineChartBarData(
          isCurved: false,
          color: kRed,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(show: false),
          dashArray: [
            5,
            5
          ],
          spots: const [
            FlSpot(0, 0),
            FlSpot(1, 7000),
            FlSpot(2, 12000),
            FlSpot(3, 23800),
            FlSpot(4, 20000),
            FlSpot(5, 30000),
          ]);
}
