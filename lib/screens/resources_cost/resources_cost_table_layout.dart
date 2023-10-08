import 'package:ddofinance/models/resources_cost/resources_cost_model.dart';
import 'package:ddofinance/providers/resources_cost/resources_cost_data_provider.dart';
import 'package:ddofinance/widgets/loaders/circular_loader.dart';
import 'package:ddofinance/screens/resources_cost/resource_cost_data_table.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


///A table layout widget for displaying resources cost data.
class ResourcesCostTableLayout extends StatelessWidget {
  final Future<List<ResourcesCostModel>>? resourcesCostData;
  final BoxConstraints constraints;

  const ResourcesCostTableLayout(
      {required this.resourcesCostData, required this.constraints, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ResourcesCostDataProvider provider = Provider.of<ResourcesCostDataProvider>(context);

    // For checking whether screen size has decreased or not.
    bool isSmallScreen = constraints.maxWidth < 1000;

    Widget dataTable = FutureBuilder<List<ResourcesCostModel>>(
      future: resourcesCostData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            snapshot.connectionState == ConnectionState.active) {
          return const CircularLoader();
          // return const CircularProgressIndicator(); // or any loading indicator
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          // Use dataFromLocalStorage to build your table
          return ResourcesCostDataTable();
        } else {
          return const Text('No data available');
        }
      },
    );

    if (isSmallScreen) {
      // Wrap the table in a SingleChildScrollView for smaller screens.
      dataTable = SingleChildScrollView(
        dragStartBehavior: DragStartBehavior.down,
        scrollDirection: Axis.horizontal,
        child: dataTable,
      );
    }
    return dataTable;
  }
}

