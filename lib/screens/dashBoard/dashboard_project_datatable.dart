import 'package:ddofinance/providers/dashboard/dashboard_provider.dart';
import 'package:ddofinance/providers/projects/projects_provider.dart';
import 'package:ddofinance/screens/dashBoard/comment_box.dart';
import 'package:ddofinance/screens/dashBoard/total_data_table.dart';
import 'package:ddofinance/theme/styles.dart';
import 'package:ddofinance/utils/constants/labels.dart';
import 'package:ddofinance/utils/device_screens/device_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'headings.dart';
import 'month_breakdown_data_table.dart';

class DashboardProjectDatatable extends StatefulWidget {
  final String headingText;
  final int rowsLength;

  const DashboardProjectDatatable(
      {Key? key, required this.headingText, required this.rowsLength})
      : super(key: key);

  @override
  State<DashboardProjectDatatable> createState() =>
      _DashboardProjectDatatableState();
}

class _DashboardProjectDatatableState extends State<DashboardProjectDatatable> {
  final ScrollController arrowButtonScrollController = ScrollController();
  bool _isCollapsed = false;


  @override
  Widget build(BuildContext context) {
    final Size mQ = MediaQuery.of(context).size;
    final double deviceWidth = mQ.width;
    final double deviceHeight = mQ.height;
    final DashboardProvider provider =
        Provider.of<DashboardProvider>(context, listen: true);
    final ProjectsProvider projectsProvider = Provider.of<ProjectsProvider>(context,
        listen: false);
    final bool isAndroid = DeviceOS.isAndroid;
    final bool isMonitor = DeviceScreen.isMonitor(context);
    final bool isLaptop = DeviceScreen.isLargeScreen(context);
    final bool isTablet = DeviceScreen.isTablet(context);
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final ColorScheme colorTheme = theme.colorScheme;
    final double editedHeight = (widget.headingText == Labels.monthByMonthBreakdown)
        ? deviceHeight / 1.7
        : (widget.headingText == Labels.otherExpense)
            ? deviceHeight / 2.75
            : deviceHeight / 2.35;

    final double monthBreakdownLeftMargin =
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

    final double leftMarginExpenseResource =
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

    final String lastRowBarText = (widget.headingText == Labels.otherExpense)
        ? Labels.addMore
        : Labels.showMore;

    Theme themeMethod(double margin){
      return Theme(
          data: Theme.of(context)
              .copyWith(dividerColor: colorTheme.onSurfaceVariant),
          child: Stack(
            children: [
              TotalDataTable(
                  rowColLength:
                  widget.rowsLength,
                  headingText: widget.headingText),
              Container(
                margin: EdgeInsets.only(
                    left: margin),
                child: MonthDataTable(
                  headingText: widget.headingText,
                  horizontalScrollController:
                  arrowButtonScrollController,
                  rowColLength:
                  widget.rowsLength,
                ),
              ),
            ],
          ));
    }

    return Padding(
      padding: EdgeInsets.only(left: Insets.s14),
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
                      child: (widget.headingText ==
                              Labels.monthByMonthBreakdown)
                          ? Column(
                              children: [
                                Divider(
                                  indent: DividerSizes.s2,
                                  endIndent: DividerSizes.s2,
                                  thickness: DividerSizes.scale,
                                ),
                                Flexible(
                                  child: themeMethod(monthBreakdownLeftMargin),
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
                                  themeMethod(leftMarginExpenseResource),
                                  if (widget.headingText !=
                                      Labels.monthByMonthBreakdown)
                                    (projectsProvider.toMoveNavigator ==
                                            true)
                                        ? Consumer<DashboardProvider>(
                                            builder: (context, dashboardProvider, child) {
                                              return GestureDetector(
                                                onTap: (){
                                                  dashboardProvider.lastRowBar(widget.headingText);
                                                },
                                                child: Container(
                                                  color:
                                                      colorTheme.outlineVariant,
                                                  alignment: Alignment.center,
                                                  width: deviceWidth,
                                                  height: deviceHeight / 20,
                                                  margin: EdgeInsets.all(
                                                      Insets.s30),
                                                  child: Text(lastRowBarText,
                                                      style: textTheme
                                                          .bodyMedium
                                                          ?.copyWith(
                                                              fontSize:
                                                                  FontSizes.s16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: colorTheme.primary)),
                                                ),
                                              );
                                            },
                                          )
                                        : (widget.headingText !=
                                                Labels.otherExpense)
                                            ? Consumer<DashboardProvider>(
                                      builder: (context,myData,child){
                                        return GestureDetector(
                                          onTap: () {
                                            myData.showMoreRows();
                                          },
                                          child: Container(
                                            color:
                                            colorTheme.outlineVariant,
                                            alignment: Alignment.center,
                                            width: deviceWidth,
                                            height: deviceHeight / 20,
                                            margin: EdgeInsets.all(
                                                Insets.s30),
                                            child: Text(Labels.showMore,
                                                style: textTheme
                                                    .bodyMedium
                                                    ?.copyWith(
                                                    fontSize:
                                                    FontSizes.s16,
                                                    fontWeight:
                                                    FontWeight
                                                        .bold,
                                                    color: colorTheme.primary)),
                                          ),
                                        );
                                      },
                                            )
                                            : const SizedBox.shrink()
                                ],
                              ),
                            ]
                      ),
                    ),
                    isExpanded: !_isCollapsed),
              ],
            ),
          ],
        ),
        if (provider.toggleCommentBox &&
            widget.headingText == Labels.monthByMonthBreakdown)
          CommentBox(
            xPosition: provider.boxPositionX + 200,
            yPosition: provider.boxPositionY,
          ),
      ]),
    );
  }
}
