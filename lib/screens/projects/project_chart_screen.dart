import 'package:ddofinance/screens/dashBoard/dashboard.dart';
import 'package:flutter/material.dart';

import '../dashBoard/dashboard.dart';


class ProjectChartScreen extends StatefulWidget {
  const ProjectChartScreen({super.key});

  @override
  State<ProjectChartScreen> createState() => _ProjectChartScreenState();
}

class _ProjectChartScreenState extends State<ProjectChartScreen> {
  @override
  Widget build(BuildContext context) {
    return DashBoard();
  }
}
