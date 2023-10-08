import 'package:ddofinance/providers/dashboard/dashboard_provider.dart';
import 'package:ddofinance/providers/projects/projects_provider.dart';
import 'package:ddofinance/screens/dashBoard/custom_dotted_line.dart';
import 'package:ddofinance/screens/dashBoard/custom_text_form_field.dart';
import 'package:ddofinance/screens/dashBoard/other_expense_data_row.dart';
import 'package:ddofinance/screens/dashBoard/resource_cost_data_rows.dart';
import 'package:ddofinance/theme/color_constants.dart';
import 'package:ddofinance/theme/styles.dart';
import 'package:ddofinance/utils/constants/images.dart';
import 'package:ddofinance/utils/constants/labels.dart';
import 'package:ddofinance/utils/device_screens/device_info.dart';
import 'package:ddofinance/utils/master_data.dart';
import 'package:ddofinance/utils/validators.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class TotalDataTable extends StatefulWidget {
  final String headingText;
  final int rowColLength;
  const TotalDataTable({
    Key? key,
    required this.rowColLength,
    required this.headingText,
  }) : super(key: key);

  @override
  State<TotalDataTable> createState() => _TotalDataState();
}

class _TotalDataState extends State<TotalDataTable> {
  @override
  Widget build(BuildContext context) {
    var mQ = MediaQuery.of(context).size;
    var deviceWidth = mQ.width;
    var deviceHeight = mQ.height;
    final bool isAndroid = DeviceOS.isAndroid;
    final bool isMonitor = DeviceScreen.isMonitor(context);
    final bool isLaptop = DeviceScreen.isLargeScreen(context);
    final bool isTablet = DeviceScreen.isTablet(context);
    var provider = Provider.of<DashboardProvider>(context, listen: false);
    final theme = Theme.of(context);

    final sizedBoxWidth = (isMonitor)
        ? deviceWidth / 90
        : (isLaptop)
            ? deviceWidth / 72
            : deviceWidth / 68;

    final totalTextStyle = (isAndroid)
        ? theme.textTheme.titleMedium!
            .copyWith(fontSize: FontSizes.s12, fontWeight: FontWeight.bold)
        : (isMonitor || isLaptop)
            ? theme.textTheme.titleMedium!
                .copyWith(fontSize: FontSizes.s18, fontWeight: FontWeight.bold)
            : theme.textTheme.titleMedium!
                .copyWith(fontSize: FontSizes.s14, fontWeight: FontWeight.bold);

    final namesTextStyle = (isAndroid)
        ? theme.textTheme.titleMedium!.copyWith(fontSize: FontSizes.s7)
        : (isMonitor || isLaptop)
            ? theme.textTheme.titleMedium!.copyWith(
                fontSize: FontSizes.s18,
              )
            : (isTablet)
                ? theme.textTheme.titleMedium!.copyWith(
                    fontSize: FontSizes.s12,
                  )
                : theme.textTheme.titleMedium!.copyWith(
                    fontSize: FontSizes.s10,
                  );

    final textFieldStyle = (isAndroid)
        ? theme.textTheme.titleMedium!.copyWith(
            fontSize: FontSizes.s14,
          )
        : (isMonitor)
            ? theme.textTheme.titleMedium!.copyWith(
                fontSize: FontSizes.s20,
              )
            : (isLaptop)
                ? theme.textTheme.titleMedium!.copyWith(
                    fontSize: FontSizes.s16,
                  )
                : theme.textTheme.titleMedium!.copyWith(
                    fontSize: FontSizes.s16,
                  );

    return DataTable(
      columnSpacing: 1,
      columns: List<DataColumn>.generate(
        MasterData.dashboardAndProjectTotalColumnTitles.length,
        (index) {
          if (index == 3) {
            return DataColumn(
              label: Container(
                margin: const EdgeInsets.only(left: 15.5),
                color: kGrey,
                height: deviceHeight / 1,
                width: 1,
              ),
            );
          }
          return DataColumn(
              label: Row(
            children: [
              SizedBox(width: sizedBoxWidth),
              Text(
                  ((isAndroid || isTablet) || (!isMonitor && !isLaptop))
                      ? MasterData
                          .dashboardAndProjectTotalColumnTitlesResponsive[index]
                      : MasterData.dashboardAndProjectTotalColumnTitles[index],
                  textAlign: TextAlign.center,
                  style: totalTextStyle),
            ],
          ));
        },
      ),
      rows: (widget.headingText == Labels.otherExpense)
          ? dashboardAndProjectExpenseTotalDataRows
          : (widget.headingText == Labels.resourceCostHeading)
              ? resourceTotalDataRows.sublist(0, provider.visibleRowCount)
              : List<DataRow>.generate(
                  widget.rowColLength,
                  (rowIndex) {
                    return DataRow(
                      cells: List.generate(
                          MasterData.dashboardAndProjectTotalColumnTitles
                              .length, (colIndex) {
                        if (colIndex == 0) {
                          return DataCell((rowIndex == 5 || rowIndex == 7)
                              ? const CustomDottedLine()
                              : SizedBox(
                                  width: deviceWidth / 10,
                                  child: Text(
                                    (isLaptop || isMonitor)
                                        ? MasterData
                                                .dashboardAndProjectMonthRowNames[
                                            rowIndex]
                                        : MasterData
                                                .dashboardAndProjectMonthRowNamesResponsive[
                                            rowIndex],
                                    style: namesTextStyle,
                                    textAlign: (isAndroid)
                                        ? TextAlign.left
                                        : TextAlign.start,
                                  )));
                        } else if (colIndex == 3 && rowIndex == 6) {
                          return DataCell(
                            Center(
                              child: Container(
                                margin: (!Provider.of<ProjectsProvider>(context)
                                        .toMove)
                                    ? const EdgeInsets.only(left: 15)
                                    : null,
                                color: kGrey,
                                width: 1,
                              ),
                            ),
                          );
                        } else if (colIndex == 3) {
                          return DataCell((rowIndex == 5 || rowIndex == 7)
                              ? Stack(children: [
                                  const Center(child: CustomDottedLine()),
                                  Center(
                                    child: Container(
                                      width: 1,
                                      color: kGrey,
                                      margin: rowIndex == 7
                                          ? EdgeInsets.only(
                                              bottom: 24,
                                              left: (!Provider.of<
                                                              ProjectsProvider>(
                                                          context)
                                                      .toMove)
                                                  ? 15
                                                  : 0)
                                          : (!Provider.of<ProjectsProvider>(
                                                      context,
                                                      listen: false)
                                                  .toMove)
                                              ? const EdgeInsets.only(left: 15)
                                              : null,
                                    ),
                                  )
                                ])
                              : Stack(alignment: Alignment.center, children: [
                                  Container(
                                    margin: (!Provider.of<ProjectsProvider>(
                                                context,
                                                listen: false)
                                            .toMove)
                                        ? const EdgeInsets.only(left: 15.5)
                                        : null,
                                    color: kGrey,
                                    height: deviceHeight / 10,
                                    width: 1,
                                  ),
                                  MouseRegion(
                                    onEnter: (PointerEnterEvent event) {
                                      provider.onEnterSelectMonthIcon(
                                          event, rowIndex);
                                    },
                                    onExit: (PointerExitEvent event) {
                                      provider.onExitSelectMonthIcon(
                                          event, rowIndex);
                                    },
                                    child: (Provider.of<ProjectsProvider>(
                                                context,
                                                listen: false)
                                            .toMove)
                                        ? Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              boxShadow: [
                                                BoxShadow(
                                                  color:
                                                      kBlack.withOpacity(0.3),
                                                  spreadRadius: 1,
                                                  blurRadius: 3,
                                                  offset: const Offset(0, 1),
                                                ),
                                              ],
                                            ),
                                            child: GestureDetector(
                                              onTap: () {
                                                provider.selectRow(rowIndex);
                                              },
                                              child: CircleAvatar(
                                                backgroundColor: (provider
                                                        .isSelected[rowIndex])
                                                    ? kViolet
                                                    : (provider.selectRowMonth[
                                                            rowIndex])
                                                        ? kViolet
                                                        : kWhite,
                                                foregroundColor: kWhite,
                                                radius: 16,
                                                child: (provider
                                                        .isSelected[rowIndex])
                                                    ? SvgPicture.asset(
                                                        Images.checkIcon)
                                                    : SvgPicture.asset(
                                                        Images.editSelectIcon),
                                              ),
                                            ),
                                          )
                                        : null,
                                  ),
                                ]));
                        } else if (rowIndex == 5 || rowIndex == 7) {
                          return const DataCell(CustomDottedLine());
                        } else {
                          return DataCell(Container(
                            // color: kGrey,
                            height: deviceHeight / 10,
                            width: deviceWidth / 12,
                            margin: EdgeInsets.only(
                                left: Insets.s4,
                                top: Insets.s4,
                                bottom: Insets.s4,
                                right: Insets.s4),
                            decoration: BoxDecoration(
                                color: kLightGreyShade,
                                border: Border.all(width: 1, color: kGrey),
                                borderRadius: BorderRadius.circular(5)),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: Insets.s2,
                                  right: Insets.s12,
                                  top: Insets.s18,
                                  bottom: Insets.s4),
                              child: (colIndex == 1)
                                  ? Text(provider
                                      .dashboardAndProjectMonthTotalFYValue[
                                          rowIndex]
                                      .toString())
                                  : Text(provider
                                          .dashboardAndProjectMonthTotalYTDValue[
                                      rowIndex]),
                            ),
                          ));
                        }
                      }),
                    );
                  },
                ),
    );
  }
}
