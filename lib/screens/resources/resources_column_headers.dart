import 'package:ddofinance/providers/resources/resources_provider.dart';
import 'package:ddofinance/utils/constants/material_icons.dart';
import 'package:ddofinance/utils/device_screens/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// A widget representing the header of a data column in a DataTable.
class ResourcesColumnHeaders extends StatelessWidget {
  final Map<String, dynamic> columnHeader;

  /// Creates a [DataColumnValues] widget.
  ///layed in the column header.
  /// The [sortResourcesList] is a callback function to trigger sorting.
  /// The [sortAscending] indicates whether sorting is in ascending order.
  const ResourcesColumnHeaders({required this.columnHeader, super.key});

  @override
  Widget build(BuildContext context) {
    Size mQ = MediaQuery.of(context).size;
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;
    ColorScheme colorTheme = theme.colorScheme;
    return (columnHeader['sort'])
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                columnHeader['label'],
                style:
                    textTheme.bodySmall!.copyWith(color: colorTheme.onPrimary),
              ),
              Consumer<ResourceProvider>(
                builder: (BuildContext context, value, Widget? child) {
                  return GestureDetector(
                    child:
                        (value.changeIconDirection == columnHeader['label'] &&
                                value.sortAscending == true)
                            ? Icon(
                                MaterialIcons.keyboardArrowDown,
                                size: ScreenSize.getIconSize(
                                  largeIconSize: mQ.width / 85,
                                  mediumIconSize: mQ.width / 50,
                                  smallIconSize: mQ.width / 30,
                                ) ,
                                color: colorTheme.onPrimary,
                              )
                            : Icon(
                                MaterialIcons.keyboardArrowUp,
                                size: ScreenSize.getIconSize(
                                  largeIconSize: mQ.width / 85,
                                  mediumIconSize: mQ.width / 50,
                                  smallIconSize: mQ.width / 30,
                                ) ,
                                color: colorTheme.onPrimary,
                              ),
                    onTap: () {
                      value.sortData(columnHeader['label']);
                    },
                  );
                },
              ),
            ],
          )
        : Text(columnHeader['label'],
            style: textTheme.bodySmall!.copyWith(color: colorTheme.onPrimary));
  }
}
