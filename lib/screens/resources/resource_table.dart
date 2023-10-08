
import 'package:ddofinance/screens/resources/resources_column_headers.dart';
import 'package:ddofinance/utils/master_data.dart';

import 'package:flutter/material.dart';
import 'package:ddofinance/models/resources/resources_model.dart';
import 'package:ddofinance/theme/styles.dart';

/// A custom Flutter widget for displaying a table of resources with sorting functionality.
///
/// This widget takes a list of [ResourcesModel] and displays it in a DataTable.
class ResourceTable extends StatelessWidget {
  /// The list of resources to display in the table.
  ///- [filtered]: A list of filtered resources to display.
  late List<ResourcesModel> filtered;
  ResourceTable({Key? key, required this.filtered}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the width of the screen using MediaQuery.
    final deviceWidth = MediaQuery.of(context).size.width;
     final textTheme = Theme.of(context).textTheme.bodyMedium;
    // Create a DataTable to display the resource data.
    return DataTable(columns: <DataColumn>[
      for (var columnHeader in MasterData.resourceTableColumnHeaders)
        DataColumn(label: ResourcesColumnHeaders(columnHeader: columnHeader)),
    ], rows: <DataRow>[
      for (final i in filtered)
        DataRow(cells: [
          DataCell(Text(
            i.employeeName,
            style: textTheme,
          )),
          DataCell(Text(
            i.clientName,
            style: textTheme,
          )),
          DataCell(Text(
            i.projectName,
            style: textTheme,
          )),
          DataCell(Text(
            i.startDate,
            style: textTheme,
          )),
          DataCell(Text(
            i.endDate,
            style: textTheme,
          )),
          DataCell(Padding(
            padding: EdgeInsets.only(left: Insets.scale*50),
            child: Text(
              '${i.resourceCost}',
              style:textTheme,
            ),
          )),
        ])
    ]);
  }
}
