import 'package:finance_forecasting/widgets/data_grid_table.dart';
import 'package:finance_forecasting/widgets/month_by_month_breakdown.dart';
import 'package:finance_forecasting/widgets/scroll_view_behavior.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
      title: 'Flutter Demo',
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   useMaterial3: true,
      // ),
      debugShowCheckedModeBanner: false,
      home: MonthByMonthBreakDown(),
    );
  }
}
