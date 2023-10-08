import 'package:ddofinance/providers/projects/projects_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ddofinance/utils/constants/material_icons.dart';

/// A widget representing the header of a data column in a DataTable.
class ProjectsColumnHeaderData extends StatelessWidget {
  final Map<String, dynamic> columnHeader;

  /// Creates a [DataColumnValues] widget.
  const ProjectsColumnHeaderData({required this.columnHeader, super.key});

  @override
  Widget build(BuildContext context) {
    MediaQueryData mQ = MediaQuery.of(context);
    double deviceWidth = mQ.size.width;
    final theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final ColorScheme colorTheme = theme.colorScheme;

    ///If columnHeader sort property is true then we'll display Row widget.
    return (columnHeader['sort'])
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(columnHeader['label'],
                  style: textTheme.bodySmall!
                      .copyWith(color: colorTheme.onPrimary)),
              const SizedBox(width: 5),
              Consumer<ProjectsProvider>(
                builder:
                    (BuildContext context, projectsProvider, Widget? child) {
                  return GestureDetector(
                    child: (projectsProvider.changeIconDirection ==
                                columnHeader['label'] &&
                            projectsProvider.sortAscending == true)
                        ? Icon(
                            MaterialIcons.keyboardArrowDown,
                            size: deviceWidth / 79,
                            color: colorTheme.onPrimary,
                          )
                        : Icon(
                            MaterialIcons.keyboardArrowUp,
                            size: deviceWidth / 89,
                            color: colorTheme.onPrimary,
                          ),
                    onTap: () {
                      Provider.of<ProjectsProvider>(context, listen: false)
                          .sortData(columnHeader['label']);
                    },
                  );
                },
              ),
            ],
          )

        ///If columnHeader sort property is false then we'll display Text widget.
        : Text(
            columnHeader['label'],
            style: textTheme.bodySmall!.copyWith(color: colorTheme.onPrimary),
          );
  }
}
