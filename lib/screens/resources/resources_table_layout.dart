import 'package:ddofinance/models/resources/resources_model.dart';
import 'package:ddofinance/providers/resources/resources_provider.dart';
import 'package:ddofinance/screens/resources/resource_table.dart';
import 'package:ddofinance/widgets/loaders/circular_loader.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// A table layout widget for displaying resources data.
class ResourcesTableLayout extends StatelessWidget {
  final Future<List<ResourcesModel>>? resourcesData;
  final BoxConstraints constraints;

  const ResourcesTableLayout({
    required this.resourcesData,
    required this.constraints,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Access the ResourceProvider using Provider.of
    final resourceProvider = Provider.of<ResourceProvider>(context);

    // Check if the screen size is small
    bool isSmallScreen = constraints.maxWidth < 1000;

    // Widget to display the data table based on the future
    Widget dataTable = FutureBuilder<List<ResourcesModel>>(
      future: resourcesData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            snapshot.connectionState == ConnectionState.active) {
          return const CircularLoader(); // Show loading indicator
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}'); // Display error if any
        } else if (snapshot.hasData) {
          // Use dataFromLocalStorage to build your table
          final dataFromLocalStorage = snapshot.data!;
          return ResourceTable(
            filtered: resourceProvider.filteredSearchBoxData,
          );
        } else {
          return const Text('No data available'); // Show no data message
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
    return dataTable; // Return the table widget
  }
}