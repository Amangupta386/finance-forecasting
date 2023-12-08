import 'package:ddofinance/providers/projects/projects_provider.dart';
import 'package:ddofinance/screens/dashBoard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardAndProjectDatatableScreen extends StatefulWidget {
  const DashboardAndProjectDatatableScreen({super.key});

  @override
  State<DashboardAndProjectDatatableScreen> createState() =>
      _DashboardAndProjectDatatableScreenState();
}

class _DashboardAndProjectDatatableScreenState
    extends State<DashboardAndProjectDatatableScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ProjectsProvider>(context, listen: false).setToMove(true);
  }

  @override
  Widget build(BuildContext context) {
    return const DashBoard();
  }
}
