import 'package:ddofinance/providers/resources/resources_provider.dart';
import 'package:ddofinance/screens/resources/resources_column_headers.dart';
import 'package:ddofinance/utils/master_data.dart';
import 'package:flutter/material.dart';
import 'package:ddofinance/models/resources/resources_model.dart';
import 'package:ddofinance/theme/styles.dart';
import 'package:provider/provider.dart';

/// A custom Flutter widget for displaying a table of resources with sorting functionality.
///
/// This widget takes a list of [ResourcesModel] and displays it in a DataTable.
class ResourceTable extends StatelessWidget {
  /// The list of resources to display in the table.
  ///- [filtered]: A list of filtered resources to display.

  const ResourceTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filtered =
        Provider.of<ResourceProvider>(context).filteredSearchBoxData;
    // Get the width of the screen using MediaQuery.
    final theme = Theme.of(context);
    final textTheme = theme.textTheme.bodySmall;
    final colorTheme = theme.colorScheme;
    final deviceWidth = MediaQuery.of(context).size.width;
    // Create a DataTable to display the resource data.
    return DataTable(
        columns: <DataColumn>[
          for (var columnHeader in MasterData.resourceTableColumnHeaders)
            DataColumn(
                label: ResourcesColumnHeaders(columnHeader: columnHeader)),
        ],
        rows: filtered.map((i) {
          return DataRow(cells: [
            DataCell(SizedBox(
              width: deviceWidth / 9,
              child: Tooltip(
                textStyle: TextStyle(
                  color: colorTheme.onBackground,
                  fontSize: FontSizes.s14,
                ),
                decoration: BoxDecoration(
                  color: colorTheme.secondary,
                  border: Border.all(color: colorTheme.onPrimary),
                  borderRadius: BorderRadius.circular(Insets.s3),
                ),
                message: i.employeeName,
                child: Text(
                  i.employeeName,
                  style: textTheme,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )),
            DataCell(SizedBox(
              width: deviceWidth / 9,
              child: Tooltip(
                textStyle: TextStyle(
                  color: colorTheme.onBackground,
                  fontSize: FontSizes.s14,
                ),
                decoration: BoxDecoration(
                  color: colorTheme.secondary,
                  border: Border.all(color: colorTheme.onPrimary),
                  borderRadius: BorderRadius.circular(Insets.s3),
                ),
                message: i.clientName,
                child: Text(
                  i.clientName,
                  style: textTheme,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )),
            DataCell(SizedBox(
              width: deviceWidth / 9,
              child: Tooltip(
                textStyle: TextStyle(
                  color: colorTheme.onBackground,
                  fontSize: FontSizes.s14,
                ),
                decoration: BoxDecoration(
                  color: colorTheme.secondary,
                  border: Border.all(color: colorTheme.onPrimary),
                  borderRadius: BorderRadius.circular(Insets.s3),
                ),
                message: i.projectName,
                child: Text(
                  i.projectName,
                  style: textTheme,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
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
              padding: EdgeInsets.only(left: Insets.scale * 50),
              child: Text(
                i.resourceCost,
                style: textTheme,
              ),
            )),
          ]);
        }).toList());
  }
}
