import 'package:ddofinance/models/resources_cost/resources_cost_model.dart';
import 'package:ddofinance/providers/authentication/auth_provider.dart';
import 'package:ddofinance/screens/resources_cost/resource_cost_data_table.dart';
import 'package:ddofinance/widgets/loaders/all_loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

///A table layout widget for displaying resources cost data.
class ResourcesCostTableLayout extends StatelessWidget {
  final Future<List<ResourcesCostModel>>? resourcesCostData;
  final BoxConstraints constraints;

  const ResourcesCostTableLayout(
      {required this.resourcesCostData, required this.constraints, super.key});

  @override
  Widget build(BuildContext context) {
    AuthProvider provider = Provider.of<AuthProvider>(context);
    bool isSmallScreen = constraints.maxWidth < 1000;

    Widget dataTable = FutureBuilder<List<ResourcesCostModel>>(
      future: resourcesCostData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            snapshot.connectionState == ConnectionState.active) {
          return const Center(child: CircularLoader());
          // return const CircularProgressIndicator(); // or any loading indicator
        } else if (snapshot.hasError) {
          provider.alertBox(context);
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          // Use dataFromLocalStorage to build your table
          return const ResourcesCostDataTable();
        } else {
          return const Text('No data available');
        }
      },
    );

    if (isSmallScreen) {
      // Wrap the table in a SingleChildScrollView for smaller screens.
      dataTable = dataTable;
    }
    return dataTable;
  }
}
