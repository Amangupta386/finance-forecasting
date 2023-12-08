import 'package:ddofinance/models/resources/resources_model.dart';
import 'package:ddofinance/providers/authentication/auth_provider.dart';
import 'package:ddofinance/screens/resources/resource_table.dart';
import 'package:ddofinance/utils/constants/labels.dart';
import 'package:ddofinance/widgets/loaders/all_loader.dart';
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
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = Provider.of<AuthProvider>(context);

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
          authProvider.alertBox(context);
          return Text('Error: ${snapshot.error}'); // Display error if any
        } else if (snapshot.connectionState == ConnectionState.done) {
          return const ResourceTable();
        } else {
          return const Text(Labels.noData); // Show no data message
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
