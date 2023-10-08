import 'package:ddofinance/models/projects/project.dart';
import 'package:ddofinance/screens/projects/projects_table.dart';
import 'package:ddofinance/widgets/loaders/circular_loader.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// A widget representing the layout of the projects table.
class ProjectsTableLayout extends StatelessWidget {
  /// A future containing a list of project data.
  final Future<List<ProjectsModel>>? projectsData;

  /// Constraints for the widget.
  final BoxConstraints? constraints;

  /// Creates a [ProjectsTableLayout] widget.
  const ProjectsTableLayout({
    required this.projectsData,
    this.constraints,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// Check if the screen is considered small.
    bool isSmallScreen = constraints!.maxWidth < 1200;

    /// Define a widget that represents the data table.
    Widget dataTable = FutureBuilder<List<ProjectsModel>>(
      future: projectsData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            snapshot.connectionState == ConnectionState.active) {
          /// Display a circular loader while data is loading.
          return const CircularLoader();
        } else if (snapshot.hasError) {
          /// Display an error message if there's an error.
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          /// Display the projects table when data is available.
          return const ProjectsTable();
        } else {
          /// Display a message when no data is available.
          return const Text('No data available');
        }
      },
    );

    if (isSmallScreen) {
      /// Wrap the table in a SingleChildScrollView for smaller screens.
      dataTable = SingleChildScrollView(
        dragStartBehavior: DragStartBehavior.down,
        scrollDirection: Axis.horizontal,
        child: dataTable,
      );
    }
    return dataTable;
  }
}
