import 'package:ddofinance/providers/projects/projects_provider.dart';
import 'package:ddofinance/screens/projects/projects_column_headers.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:ddofinance/utils/constants/images.dart';
import 'package:ddofinance/utils/master_data.dart';
import 'package:ddofinance/widgets/image_asset.dart';

/// A widget that displays a data table of projects.
class ProjectsTable extends StatefulWidget {
  const ProjectsTable({super.key});

  @override
  State<ProjectsTable> createState() => _ProjectsTableState();
}

class _ProjectsTableState extends State<ProjectsTable> {
  @override
  Widget build(BuildContext context) {
    final tooltipDecoration = BoxDecoration(
      color: Colors.white, // Set the background color to white.
      border: Border.all(color: Colors.grey), // Add a border.
      borderRadius: BorderRadius.circular(3.0), // Add border radius.
    );

    /// Access the provider for projects data.
    ProjectsProvider provider = Provider.of<ProjectsProvider>(context);

    /// Access the theme and screen dimensions.
    ThemeData theme = Theme.of(context);
    MediaQueryData mQ = MediaQuery.of(context);
    double deviceWidth = mQ.size.width;
    final ColorScheme colorTheme = theme.colorScheme;

    return DataTable(
        columns: [
          for (var columnHeader in MasterData.projectTableColumnHeaders)
            DataColumn(

                ///[ProjectsColumnHeaderData] Displaying data table headers
                label: ProjectsColumnHeaderData(
              columnHeader: columnHeader,
            ))
        ],
        rows: List.generate(provider.filteredSearchBoxData.length, (int index) {
          return DataRow(cells: [
            DataCell(
              onTap: () {
                setState(() {
                  context.goNamed('projectChartScreen');
                  provider.setProjectIndex(index);
                  provider.setToMove(true);
                });
              },
              SizedBox(
                width: deviceWidth / 9,
                child: Tooltip(
                  textStyle: const TextStyle(color: Colors.black, fontSize: 14),
                  decoration: tooltipDecoration,
                  message: provider.filteredSearchBoxData[index].customerName,
                  child: Text(
                    provider.filteredSearchBoxData[index].customerName,
                    style: theme.textTheme.bodySmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
            DataCell(SizedBox(
              width: deviceWidth / 9,
              child: Tooltip(
                textStyle: const TextStyle(color: Colors.black, fontSize: 14),
                decoration: tooltipDecoration,
                message: provider.filteredSearchBoxData[index].projectName,
                child: Text(
                  provider.filteredSearchBoxData[index].projectName,
                  style: theme.textTheme.bodySmall,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )),
            DataCell(Text(
              provider.filteredSearchBoxData[index].forecast.toString(),
              style: theme.textTheme.bodySmall,
            )),
            DataCell(Text(
              provider.filteredSearchBoxData[index].actual.toString(),
              style: theme.textTheme.bodySmall,
            )),
            DataCell(
                //Displaying color and data cell data according to status.
                provider.buildStatusRow(index, context)),
            DataCell(onTap: () {
              setState(() {
                context.goNamed('projectChartScreen');
                provider.setProjectIndex(index);
                provider.setToMove(true);
              });
            },
                Row(
                  children: [
                    ConstrainedBox(
                        constraints:
                            BoxConstraints.tightFor(width: deviceWidth / 50),
                        child: const ImageAsset(imageName: Images.editIcon)),
                    Text(
                      'Edit',
                      style: theme.textTheme.bodySmall!
                          .copyWith(color: colorTheme.onTertiary),
                    ),
                  ],
                )),
          ]);
        }));
  }
}
