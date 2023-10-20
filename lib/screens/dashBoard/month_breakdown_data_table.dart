import 'package:ddofinance/providers/dashboard/dashboard_provider.dart';
import 'package:ddofinance/providers/projects/projects_provider.dart';
import 'package:ddofinance/screens/dashBoard/custom_text_form_field.dart';
import 'package:ddofinance/screens/dashBoard/resource_cost_data_rows.dart';
import 'package:ddofinance/theme/color_constants.dart';
import 'package:ddofinance/theme/styles.dart';
import 'package:ddofinance/utils/constants/labels.dart';
import 'package:ddofinance/utils/constants/material_icons.dart';
import 'package:ddofinance/utils/device_screens/device_info.dart';
import 'package:ddofinance/utils/master_data.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'custom_dotted_line.dart';
import 'other_expense_data_row.dart';

class MonthDataTable extends StatefulWidget {
  final String headingText;
  final ScrollController horizontalScrollController;
  final int? rowColLength;
  const MonthDataTable({
    Key? key,
    required this.horizontalScrollController,
    required this.rowColLength,
    required this.headingText,
  }) : super(key: key);

  @override
  State<MonthDataTable> createState() => _MonthDataTableState();
}

class _MonthDataTableState extends State<MonthDataTable> {
  int currentRowIndex = 0;
  int currentColumnIndex = 0;

  @override
  void initState() {
    super.initState();
    loadProjectsScreenTableData(false);
  }

  Future<dynamic> loadProjectsScreenTableData(bool newData) async {
    // await CellLocalStorage.saveDataLocalStorage(newData, context);
    // var getLocalData = await CellLocalStorage.getDataLocalStorage();
    // DashboardProvider provider =
    //     Provider.of<DashboardProvider>(context, listen: false);
    // provider.localData = getLocalData;
    // provider.dashboardAndProjectMonthTextValue = List.generate(
    //     MasterData.dashboardAndProjectMonthRowNames.length,
    //     (rowIndex) => List<String>.generate(
    //         MasterData.dashboardAndProjectMonthColumnsNames.length,
    //         (cellIndex) => (rowIndex == 0)
    //             ? provider.localData[rowIndex].dropDownValue[cellIndex]
    //             : (rowIndex == 1)
    //                 ? provider.localData[rowIndex].actualRevenue[cellIndex]
    //                 : (rowIndex == 2)
    //                     ? provider
    //                         .localData[rowIndex].forecastedCollection[cellIndex]
    //                     : (rowIndex == 3)
    //                         ? provider
    //                             .localData[rowIndex].actualCollection[cellIndex]
    //                         : (rowIndex == 4)
    //                             ? provider
    //                                 .localData[rowIndex].monthlyCost[cellIndex]
    //                             : (rowIndex == 5)
    //                                 ? provider.localData[rowIndex]
    //                                     .dottedLine1[cellIndex]
    //                                 : (rowIndex == 6)
    //                                     ? provider.localData[rowIndex]
    //                                         .monthlyDeviation[cellIndex]
    //                                     : provider.localData[rowIndex]
    //                                         .dottedLine2[cellIndex]));
    // provider.notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    var mQ = MediaQuery.of(context).size;
    var deviceWidth = mQ.width;
    var deviceHeight = mQ.height;
    final theme = Theme.of(context);
    DashboardProvider provider =
        Provider.of<DashboardProvider>(context, listen: false);
    final bool isAndroid = DeviceOS.isAndroid;
    final bool isMonitor = DeviceScreen.isMonitor(context);
    final bool isLaptop = DeviceScreen.isLargeScreen(context);
    final bool isTablet = DeviceScreen.isTablet(context);

    final monthColumnTextStyle = (isAndroid)
        ? theme.textTheme.titleMedium!.copyWith(
            fontSize: FontSizes.s14,
          )
        : (isMonitor || isLaptop)
            ? theme.textTheme.titleMedium!.copyWith(
                fontSize: FontSizes.s18,
              )
            : theme.textTheme.titleMedium!.copyWith(
                fontSize: FontSizes.s16,
              );

    final iconPosition = (isMonitor)
        ? PositionSizes.s120
        : (isLaptop)
            ? PositionSizes.s98
            : (isTablet)
                ? PositionSizes.s45
                : PositionSizes.s31;
    final iconSize = (isMonitor)
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
          horizontalMargin:
              (Provider.of<ProjectsProvider>(context).toMove == true) ? 20 : 10,
          columnSpacing: 2,
          columns: List<DataColumn>.generate(
            MasterData
                .dashboardAndProjectMonthlyData[0].monthValues!.length,
            (index) => DataColumn(
                label: Row(children: [
              SizedBox(
                width: deviceWidth / 50,
              ),
              Text(
                MasterData.dashboardAndProjectMonthlyData[0]
                    .monthValues![index].label,
                textAlign: TextAlign.center,
                style: monthColumnTextStyle,
              )
            ])),
          ),
          rows: (widget.headingText == Labels.otherExpense)
              ? dashboardAndProjectExpenseMonthDataRows
              : (widget.headingText == Labels.resourceCostHeading)
                  ? resourceMonthDataRows.sublist(0, provider.visibleRowCount)
                  : List<DataRow>.generate(
                      8,
                      (rowIndex) => DataRow(
                        cells: List.generate(12, (cellIndex) {
                          return DataCell(
                            (rowIndex == 5 || rowIndex == 7)
                                ? const CustomDottedLine()
                                : provider.isSelect[rowIndex]
                                    ? Padding(
                                        padding: EdgeInsets.only(
                                            left: Insets.s2,
                                            right: Insets.s12,
                                            top: Insets.s5,
                                            bottom: Insets.s4),
                                        child: CustomTextFormField(
                                          rowIndex: rowIndex,
                                          cellIndex: cellIndex,
                                          textFormFieldName:
                                              Labels.monthBreakdownTextField,
                                          rowLength: 8,
                                          colLength: MasterData
                                              .dashboardAndProjectMonthlyData[0].monthValues!.length,
                                        ))
                                    : MouseRegion(
                                        onEnter: (PointerEnterEvent event) {
                                          provider.enterMonthBlock(
                                              event, cellIndex, rowIndex);
                                        },
                                        onExit: (PointerExitEvent event) {
                                          provider.exitMonthBlock(
                                              event, cellIndex, rowIndex);
                                        },
                                        child: Container(
                                            height: deviceHeight / 5,
                                            width: (isMonitor)
                                                ? deviceWidth / 11.6
                                                : deviceWidth / 13.5,
                                            margin: EdgeInsets.only(
                                                left: (cellIndex == 0 &&
                                                        Provider.of<ProjectsProvider>(context)
                                                                .toMove ==
                                                            false)
                                                    ? 15
                                                    : 4,
                                                right: 4,
                                                top: 4,
                                                bottom: 4),
                                            decoration: BoxDecoration(
                                                color: kLightGreyShade,
                                                border: Border.all(
                                                    color: provider.isValidMonthBreakdown[rowIndex]
                                                            [cellIndex]
                                                        ? kRed
                                                        : kGrey,
                                                    width:
                                                        (provider.isValidMonthBreakdown[rowIndex]
                                                                [cellIndex])
                                                            ? 1.5
                                                            : 1),
                                                borderRadius:
                                                    BorderRadius.circular(3)),
                                            child: Stack(
                                              children: [
                                                if (provider
                                                        .monthBlock[rowIndex]
                                                    [cellIndex])
                                                  Positioned(
                                                    left: iconPosition,
                                                    child: MouseRegion(
                                                      onEnter:
                                                          (PointerEnterEvent
                                                              event) {
                                                        provider.enterMonthIcon(
                                                            event,
                                                            cellIndex,
                                                            rowIndex);
                                                      },
                                                      onExit: (PointerExitEvent
                                                          event) {
                                                        provider.exitMonthIcon(
                                                            event,
                                                            cellIndex,
                                                            rowIndex);
                                                      },
                                                      child: GestureDetector(
                                                        onTapDown:
                                                            (TapDownDetails
                                                                details) {
                                                          provider
                                                              .openCommentBox(
                                                                  context,
                                                                  details,rowIndex,cellIndex);
                                                        },
                                                        child: Icon(
                                                          (!Provider.of<ProjectsProvider>(
                                                                      context)
                                                                  .toMove)
                                                              ? MaterialIcons
                                                                  .noteIcon
                                                              : MaterialIcons
                                                                  .noteAdd,
                                                          size: iconSize,
                                                          color: (provider.monthIcon[
                                                                      rowIndex]
                                                                  [cellIndex])
                                                              ? kGrey
                                                              : kLightGrey,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                else
                                                  const SizedBox.shrink(),
                                                CustomTextFormField(
                                                  rowIndex: rowIndex,
                                                  cellIndex: cellIndex,
                                                  textFormFieldName: Labels
                                                      .monthBreakdownTextField,
                                                  rowLength: 8,
                                                  colLength: MasterData
                                                      .dashboardAndProjectMonthlyData[0].monthValues!.length,
                                                ),
                                              ],
                                            )),
                                      ),
                          );
                        }),
                        selected: provider.isSelected[rowIndex],
                      ),
                    ),
        ),
      ),
    );
  }
}
