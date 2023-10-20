import 'package:ddofinance/models/dashboard/add_row_other_expense.dart';
import 'package:ddofinance/providers/dashboard/dashboard_provider.dart';
import 'package:ddofinance/providers/projects/projects_provider.dart';
import 'package:ddofinance/screens/dashBoard/comment_box.dart';
import 'package:ddofinance/screens/dashBoard/custom_drop_down.dart';
import 'package:ddofinance/screens/dashBoard/total_data_table.dart';
import 'package:ddofinance/theme/color_constants.dart';
import 'package:ddofinance/theme/styles.dart';
import 'package:ddofinance/utils/constants/labels.dart';
import 'package:ddofinance/utils/device_screens/device_info.dart';
import 'package:ddofinance/utils/master_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'headings.dart';
import 'month_breakdown_data_table.dart';

class DashboardProjectDatatable extends StatefulWidget {
  final String headingText;
  final int firstColRowLength;

  const DashboardProjectDatatable(
      {Key? key, required this.headingText, required this.firstColRowLength})
      : super(key: key);

  @override
  State<DashboardProjectDatatable> createState() => _DashboardProjectDatatableState();
}

class _DashboardProjectDatatableState extends State<DashboardProjectDatatable> {
  final ScrollController arrowButtonScrollController = ScrollController();
  bool _isCollapsed = false;

  void lastRowBar(DashboardProvider provider) {
    (widget.headingText == Labels.otherExpense)
        ? provider.addRowExpenseDatatable(context)
        : provider.showMoreRows();
  }

  @override
  Widget build(BuildContext context) {
    var mQ = MediaQuery.of(context).size;
    var deviceWidth = mQ.width;
    var deviceHeight = mQ.height;
    DashboardProvider provider =
        Provider.of<DashboardProvider>(context, listen: true);
    final bool isAndroid = DeviceOS.isAndroid;
    final bool isMonitor = DeviceScreen.isMonitor(context);
    final bool isLaptop = DeviceScreen.isLargeScreen(context);
    final bool isTablet = DeviceScreen.isTablet(context);
    final theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final ColorScheme colorTheme = theme.colorScheme;
    final editedHeight = (widget.headingText == Labels.monthByMonthBreakdown)
        ? deviceHeight / 1.7
        : (widget.headingText == Labels.otherExpense)
            ? deviceHeight / 2.75
            : deviceHeight / 2.35;

    final monthBreakdownLeftMargin =
        (widget.headingText == Labels.monthByMonthBreakdown)
            ? (isAndroid)
                ? deviceWidth / 2.35
                : (isMonitor)
                    ? deviceWidth / 3.27
                    : (isLaptop)
                        ? deviceWidth / 3.5
                        : (isTablet)
                            ? deviceWidth / 3.1
                            : deviceWidth / 2.55
            : 0.0;

    final leftMarginExpenseResource =
        (widget.headingText == Labels.monthByMonthBreakdown)
            ? deviceWidth / 3.27
            : (widget.headingText == Labels.resourceCostHeading)
                ? (isAndroid)
                    ? deviceWidth / 2.35
                    : (isMonitor)
                        ? deviceWidth / 3.38
                        : (isLaptop)
                            ? deviceWidth / 3.69
                            : (isTablet)
                                ? deviceWidth / 3.22
                                : deviceWidth / 2.62
                : (widget.headingText == Labels.otherExpense)
                    ? (isAndroid)
                        ? deviceWidth / 2.35
                        : (isMonitor)
                            ? deviceWidth / 3.21
                            : (isLaptop)
                                ? deviceWidth / 3.48
                                : (isTablet)
                                    ? deviceWidth / 3.08
                                    : deviceWidth / 2.52
                    : deviceWidth;

    final lastRowBarText = (widget.headingText == Labels.otherExpense)
        ? Labels.addMore
        : Labels.showMore;
    return Padding(
      padding:  EdgeInsets.only(left: Insets.s14),
      child: Stack(children: [
        Column(
          children: [
            ExpansionPanelList(
              elevation: 0,
              expansionCallback: (index, isExpanded) {
                setState(() {
                  _isCollapsed = !_isCollapsed;
                });
              },
              children: [
                ExpansionPanel(
                    headerBuilder: (context, isExpanded) {
                      return Headings(
                        isCollapsed: _isCollapsed,
                        headingText: widget.headingText,
                        scrollerController: arrowButtonScrollController,
                      );
                    },
                    body: SizedBox(
                      width: deviceWidth,
                      height: editedHeight,
                      child: (widget.headingText == Labels.monthByMonthBreakdown)
                          ? Column(
                              children: [
                                Divider(
                                  indent: DividerSizes.s2,
                                  endIndent: DividerSizes.s2,
                                  thickness: DividerSizes.scale,
                                ),
                                Flexible(
                                  child: Theme(
                                      data: Theme.of(context)
                                          .copyWith(dividerColor: kTransparent),
                                      child: Stack(
                                        children: [
                                          TotalDataTable(
                                              rowColLength:
                                                  widget.firstColRowLength,
                                              headingText: widget.headingText),
                                          Container(
                                            margin: EdgeInsets.only(
                                                left: monthBreakdownLeftMargin),
                                            child: MonthDataTable(
                                              headingText: widget.headingText,
                                              horizontalScrollController:
                                                  arrowButtonScrollController,
                                              rowColLength:
                                                  widget.firstColRowLength,
                                            ),
                                          ),
                                        ],
                                      )),
                                ),
                              ],
                            )
                          : Stack(
                          children: [
                              ListView(
                                children: [
                                  Divider(
                                    indent: DividerSizes.s2,
                                    endIndent: DividerSizes.s2,
                                    thickness: DividerSizes.scale,
                                  ),
                                  Theme(
                                      data: Theme.of(context)
                                          .copyWith(dividerColor: kTransparent),
                                      child: Stack(
                                        children: [
                                          TotalDataTable(
                                              rowColLength:
                                                  widget.firstColRowLength,
                                              headingText: widget.headingText),
                                          Container(
                                            margin: EdgeInsets.only(
                                                left: leftMarginExpenseResource),
                                            child: MonthDataTable(
                                              horizontalScrollController:
                                                  arrowButtonScrollController,
                                              rowColLength:
                                                  widget.firstColRowLength,
                                              headingText: widget.headingText,
                                            ),
                                          ),
                                        ],
                                      )),
                                  if (widget.headingText !=
                                      Labels.monthByMonthBreakdown)
                                    (Provider.of<ProjectsProvider>(context,
                                                    listen: false)
                                                .toMove ==
                                            true)
                                        ? GestureDetector(
                                            onTap: () {
                                              {
                                                provider.addRowIndex++;
                                                provider
                                                    .dashboardAndProjectExpenseDropdownList
                                                    .add(CustomDropdown(
                                                  index: provider.addRowIndex,
                                                  selectedValue: '',
                                                ));
                                                provider.dropDownInitialValue
                                                    .add('Food');
                                                provider.isDropdownIndexOpen
                                                    .add(false);
                                                provider
                                                    .dashboardAndProjectExpenseTotalYTDValue
                                                    .add('0');
                                                provider
                                                    .dashboardAndProjectExpenseTotalFYValue
                                                    .add(0);
                                                provider.addRowOtherExpenseData
                                                    .add(provider
                                                        .addRowMapData[0]);
                                                provider
                                                    .isValidAddRowExpenseCost
                                                    .add(List.filled(
                                                        MasterData
                                                            .dashboardAndProjectMonthlyData[
                                                                0]
                                                            .monthValues!
                                                            .length,
                                                        false));
                                                lastRowBar(provider);
                                              }
                                            },
                                            child: Container(
                                              color: colorTheme.outlineVariant,
                                              alignment: Alignment.center,
                                              width: deviceWidth,
                                              height: deviceHeight / 20,
                                              margin: EdgeInsets.all(Insets.s30),
                                              child: Text(lastRowBarText,
                                                  style: textTheme.bodyMedium
                                                      ?.copyWith(
                                                          fontSize: FontSizes.s16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: kViolet)),
                                            ),
                                          )
                                        : (widget.headingText !=
                                                Labels.otherExpense)
                                            ? GestureDetector(
                                                onTap: () {
                                                  provider.showMoreRows();
                                                },
                                                child: Container(
                                                  color:
                                                      colorTheme.outlineVariant,
                                                  alignment: Alignment.center,
                                                  width: deviceWidth,
                                                  height: deviceHeight / 20,
                                                  margin:
                                                      EdgeInsets.all(Insets.s30),
                                                  child: Text(Labels.showMore,
                                                      style: textTheme.bodyMedium
                                                          ?.copyWith(
                                                              fontSize:
                                                                  FontSizes.s16,
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                              color: kViolet)),
                                                ),
                                              )
                                            : const SizedBox.shrink()
                                ],
                              ),
                            ]),
                    ),
                    isExpanded: !_isCollapsed),
              ],
            ),
          ],
        ),
        if (provider.toggleCommentBox &&
            widget.headingText == Labels.monthByMonthBreakdown)
          CommentBox(
            xPosition: provider.boxPositionX,
            yPosition: provider.boxPositionY,
          ),
      ]),
    );
  }
}


