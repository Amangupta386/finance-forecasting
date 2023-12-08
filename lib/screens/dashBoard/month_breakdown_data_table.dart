import 'package:collection/collection.dart';
import 'package:ddofinance/providers/dashboard/dashboard_provider.dart';
import 'package:ddofinance/providers/projects/projects_provider.dart';
import 'package:ddofinance/screens/dashBoard/custom_text_form_field.dart';
import 'package:ddofinance/theme/styles.dart';
import 'package:ddofinance/utils/constants/labels.dart';
import 'package:ddofinance/utils/constants/material_icons.dart';
import 'package:ddofinance/utils/device_screens/device_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'custom_dotted_line.dart';

class MonthDataTable extends StatefulWidget {
  final String headingText;
  final ScrollController horizontalScrollController;
  final int? rowColLength;
  const MonthDataTable({
    super.key,
    required this.horizontalScrollController,
    required this.rowColLength,
    required this.headingText,
  });

  @override
  State<MonthDataTable> createState() => _MonthDataTableState();
}

class _MonthDataTableState extends State<MonthDataTable> {
  int currentRowIndex = 0;
  int currentColumnIndex = 0;
  @override
  void initState() {
    super.initState();
    Provider.of<DashboardProvider>(context, listen: false)
        .updateDashboardAndProjectMonthBreakdownData();
  }

  @override
  Widget build(BuildContext context) {
    final Size mQ = MediaQuery.of(context).size;
    final double deviceWidth = mQ.width;
    final double deviceHeight = mQ.height;
    final DashboardProvider provider = Provider.of<DashboardProvider>(context);
    final ProjectsProvider projectsProvider =
        Provider.of<ProjectsProvider>(context);
    final bool isAndroid = DeviceOS.isAndroid;
    final bool isMonitor = DeviceScreen.isMonitor(context);
    final bool isLaptop = DeviceScreen.isLargeScreen(context);
    final bool isTablet = DeviceScreen.isTablet(context);
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final ColorScheme colorTheme = theme.colorScheme;

    final TextStyle monthColumnTextStyle = (isAndroid)
        ? textTheme.titleMedium!.copyWith(
            fontSize: FontSizes.s14,
          )
        : (isMonitor || isLaptop)
            ? textTheme.titleMedium!.copyWith(
                fontSize: FontSizes.s18,
              )
            : textTheme.titleMedium!.copyWith(
                fontSize: FontSizes.s16,
              );

    final double iconPosition = (isMonitor)
        ? PositionSizes.s120
        : (isLaptop)
            ? PositionSizes.s98
            : (isTablet)
                ? PositionSizes.s45
                : PositionSizes.s25;

    final double iconSize = (isMonitor)
        ? IconSizes.s16
        : (isLaptop)
            ? IconSizes.s14
            : IconSizes.s12;

    return SizedBox(
      width: deviceWidth / 1.45,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        controller: widget.horizontalScrollController,
        child: DataTable(
          horizontalMargin: (projectsProvider.toMoveNavigator == true)
              ? Insets.s20
              : Insets.s10,
          columnSpacing: 2,
          columns: List<DataColumn>.generate(
            provider
                .dashboardAndProjectMonthBreakdownData[0].monthValues.length,
            (index) => DataColumn(
                label: Row(children: [
              SizedBox(
                width: deviceWidth / 50,
              ),
              Text(
                provider.dashboardAndProjectMonthBreakdownData[0]
                    .monthValues[index].label,
                textAlign: TextAlign.center,
                style: monthColumnTextStyle,
              )
            ])),
          ),
          rows: (widget.headingText == Labels.otherExpense)
              ? provider.dashboardAndProjectOtherExpenseModelData
                  .map((expenseRowData) => (DataRow(
                        cells: List.generate(expenseRowData.monthValues.length,
                            (colIndex) {
                          return DataCell(
                            Container(
                                height: mQ.height / 5,
                                width: mQ.width / 13.5,
                                margin: EdgeInsets.all(Insets.s4),
                                decoration: BoxDecoration(
                                    color: colorTheme.onPrimaryContainer,
                                    border: Border.all(
                                        color: !expenseRowData
                                                .monthValues[colIndex].isValid
                                            ? colorTheme.onTertiaryContainer
                                            : colorTheme.onPrimary,
                                        width: (expenseRowData
                                                .monthValues[colIndex].isValid)
                                            ? 1
                                            : 1.5),
                                    borderRadius: BorderRadius.circular(3)),
                                child: Consumer<DashboardProvider>(
                                  builder: (a, provider, c) {
                                    return CustomTextFormField(
                                      expenseRowData: expenseRowData,
                                      cellIndex: colIndex,
                                      textFormFieldName:
                                          Labels.expenseMonthTextField,
                                      rowLength: provider.addRowIndex,
                                      colLength:
                                          expenseRowData.monthValues.length,
                                    );
                                  },
                                )),
                          );
                        }),
                        // selected: isSelected[rowIndex],
                      )))
                  .toList()
              : (widget.headingText == Labels.resourceCostHeading)
                  ? provider.dashboardAndProjectResourcesCostData
                      .sublist(0, provider.visibleRowCount)
                      .map((resourceCostRowData) => DataRow(
                            cells: List.generate(
                                resourceCostRowData.monthValues.length,
                                (colIndex) {
                              return DataCell(
                                Container(
                                    height: mQ.height / 5,
                                    width: mQ.width / 13.5,
                                    margin: EdgeInsets.all(Insets.s4),
                                    decoration: BoxDecoration(
                                        color: colorTheme.onPrimaryContainer,
                                        border: Border.all(
                                            color: resourceCostRowData
                                                    .monthValues[colIndex]
                                                    .isValid
                                                ? colorTheme.onPrimary
                                                : colorTheme
                                                    .onTertiaryContainer,
                                            width: resourceCostRowData
                                                    .monthValues[colIndex]
                                                    .isValid
                                                ? 1
                                                : 1.5),
                                        borderRadius: BorderRadius.circular(3)),
                                    child: CustomTextFormField(
                                      cellIndex: colIndex,
                                      textFormFieldName:
                                          Labels.resourceMonthTextField,
                                      rowLength: 6,
                                      colLength: resourceCostRowData
                                          .monthValues.length,
                                      resourceRowData: resourceCostRowData,
                                    )),
                              );
                            }),
                          ))
                      .toList()
                  : provider.dashboardAndProjectMonthBreakdownData
                      .mapIndexed((index, monthBreakdownRow) => DataRow(
                            cells: List.generate(
                                monthBreakdownRow.monthValues.length,
                                (cellIndex) {
                              return DataCell(
                                (monthBreakdownRow.isDottedLine)
                                    ? const CustomDottedLine()
                                    : monthBreakdownRow.isSelect
                                        ? Padding(
                                            padding: EdgeInsets.only(
                                                left: Insets.s2,
                                                right: Insets.s8,
                                                top: Insets.s2,
                                                bottom: Insets.s2),
                                            child: CustomTextFormField(
                                              cellIndex: cellIndex,
                                              textFormFieldName: Labels
                                                  .monthBreakdownTextField,
                                              rowLength: 8,
                                              colLength: monthBreakdownRow
                                                  .monthValues.length,
                                              monthBreakdownRowData:
                                                  monthBreakdownRow,
                                            ))
                                        : Container(
                                            height: deviceHeight / 5,
                                            width: (isMonitor)
                                                ? deviceWidth / 11.6
                                                : deviceWidth / 13.5,
                                            margin: EdgeInsets.only(
                                                left: (cellIndex == 0 &&
                                                        projectsProvider
                                                                .toMoveNavigator ==
                                                            false)
                                                    ? Insets.s15
                                                    : Insets.s4,
                                                right: Insets.s4,
                                                top: Insets.s4,
                                                bottom: Insets.s4),
                                            decoration: BoxDecoration(
                                                color: colorTheme
                                                    .onPrimaryContainer,
                                                border: Border.all(
                                                    color: monthBreakdownRow.monthValues[cellIndex].isValid
                                                        ? colorTheme.onPrimary
                                                        : colorTheme
                                                            .onTertiaryContainer,
                                                    width: monthBreakdownRow
                                                            .monthValues[cellIndex]
                                                            .isValid
                                                        ? 1
                                                        : 1.5),
                                                borderRadius: BorderRadius.circular(3)),
                                            child: InkWell(
                                              onTap: () {},
                                              onHover: (data) {
                                                monthBreakdownRow
                                                    .monthValues[cellIndex]
                                                    .monthBlock = data;
                                              },
                                              child: Stack(
                                                children: [
                                                  if (monthBreakdownRow
                                                      .monthValues[cellIndex]
                                                      .monthBlock)
                                                    Positioned(
                                                      left: iconPosition,
                                                      child: InkWell(
                                                        onTap: () {},
                                                        onHover: (data) {
                                                          monthBreakdownRow
                                                              .monthValues[
                                                                  cellIndex]
                                                              .monthIcon = data;
                                                        },
                                                        child: GestureDetector(
                                                          onTapDown:
                                                              (TapDownDetails
                                                                  details) {
                                                            provider
                                                                .openCommentBox(
                                                                    context,
                                                                    details,
                                                                    index,
                                                                    cellIndex);
                                                          },
                                                          child: Icon(
                                                            (!projectsProvider
                                                                    .toMoveNavigator)
                                                                ? MaterialIcons
                                                                    .noteIcon
                                                                : MaterialIcons
                                                                    .noteAdd,
                                                            size: iconSize,
                                                            color: (monthBreakdownRow
                                                                    .monthValues[
                                                                        cellIndex]
                                                                    .monthIcon)
                                                                ? colorTheme
                                                                    .onPrimary
                                                                : colorTheme
                                                                    .tertiaryContainer,
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  else
                                                    const SizedBox.shrink(),
                                                  CustomTextFormField(
                                                    cellIndex: cellIndex,
                                                    textFormFieldName: Labels
                                                        .monthBreakdownTextField,
                                                    rowLength: 8,
                                                    colLength: monthBreakdownRow
                                                        .monthValues.length,
                                                    monthBreakdownRowData:
                                                        monthBreakdownRow,
                                                  ),
                                                ],
                                              ),
                                            )),
                              );
                            }),
                            selected: monthBreakdownRow.isTotalSelected,
                          ))
                      .toList(),
        ),
      ),
    );
  }
}
