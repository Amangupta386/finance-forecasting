import 'package:ddofinance/models/projects/project.dart';
import 'package:ddofinance/screens/projects/projects_table.dart';
import 'package:ddofinance/widgets/loaders/all_loader.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ddofinance/providers/authentication/auth_provider.dart';

/// A widget representing the layout of the projects table.
class ProjectsTableLayout extends StatelessWidget {
  /// A future containing a list of project data.
  final Future<List<ProjectModel>>? projectsData;

  /// Constraints for the widget.
  final BoxConstraints? constraints;

  /// Creates a [ProjectsTableLayout] widget.
  const ProjectsTableLayout({
    required this.projectsData,
    this.constraints,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = Provider.of<AuthProvider>(context);

    /// Check if the screen is considered small.
    bool isSmallScreen = constraints!.maxWidth < 1200;

    /// Define a widget that represents the data table.
    Widget dataTable = FutureBuilder<List<ProjectModel>>(
      future: projectsData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            snapshot.connectionState == ConnectionState.active) {
          /// Display a circular loader while data is loading.
          return const Center(child: CircularLoader());
        }

        if (snapshot.hasError) {
          authProvider.alertBox(context);

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
