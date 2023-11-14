import 'package:collection/collection.dart';
import 'package:ddofinance/providers/dashboard/dashboard_provider.dart';
import 'package:ddofinance/providers/projects/projects_provider.dart';
import 'package:ddofinance/screens/dashBoard/custom_dotted_line.dart';
import 'package:ddofinance/screens/dashBoard/custom_drop_down.dart';
import 'package:ddofinance/theme/color_constants.dart';
import 'package:ddofinance/theme/styles.dart';
import 'package:ddofinance/utils/constants/images.dart';
import 'package:ddofinance/utils/constants/labels.dart';
import 'package:ddofinance/utils/device_screens/device_info.dart';
import 'package:ddofinance/utils/master_data.dart';
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
    final Size mQ = MediaQuery.of(context).size;
    final double deviceWidth = mQ.width;
    final double deviceHeight = mQ.height;
    final bool isAndroid = DeviceOS.isAndroid;
    final bool isMonitor = DeviceScreen.isMonitor(context);
    final bool isLaptop = DeviceScreen.isLargeScreen(context);
    final bool isTablet = DeviceScreen.isTablet(context);
    final ProjectsProvider projectsProvider =
        Provider.of<ProjectsProvider>(context);
    final DashboardProvider provider =
        Provider.of<DashboardProvider>(context, listen: true);
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final ColorScheme colorTheme = theme.colorScheme;

    final double sizedBoxWidth = (isMonitor)
        ? deviceWidth / 90
        : (isLaptop)
            ? deviceWidth / 72
            : deviceWidth / 68;

    final TextStyle totalTextStyle = (isAndroid)
        ? textTheme.titleMedium!
            .copyWith(fontSize: FontSizes.s12, fontWeight: FontWeight.bold)
        : (isMonitor || isLaptop)
            ? textTheme.titleMedium!
                .copyWith(fontSize: FontSizes.s18, fontWeight: FontWeight.bold)
            : textTheme.titleMedium!
                .copyWith(fontSize: FontSizes.s14, fontWeight: FontWeight.bold);

    final TextStyle namesTextStyle = (isAndroid)
        ? textTheme.titleMedium!.copyWith(fontSize: FontSizes.s7)
        : (isMonitor || isLaptop)
            ? textTheme.titleMedium!.copyWith(
                fontSize: FontSizes.s18,
              )
            : (isTablet)
                ? textTheme.titleMedium!.copyWith(
                    fontSize: FontSizes.s12,
                  )
                : textTheme.titleMedium!.copyWith(
                    fontSize: FontSizes.s10,
                  );

    return DataTable(
      columnSpacing: 1,
      columns: List<DataColumn>.generate(
        MasterData.dashboardAndProjectTotalColumnTitles.length,
        (index) {
          if (index == 3) {
            return DataColumn(
              label: Container(
                margin: EdgeInsets.only(left: Insets.s15d5),
                color: colorTheme.onPrimary,
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
          ? provider.dashboardAndProjectOtherExpenseModelData
              .map((rowData) => (DataRow(
                    cells: List.generate(
                        MasterData.dashboardAndProjectTotalColumnTitles.length,
                        (colIndex) {
                      if (colIndex == 0) {
                        return DataCell(SizedBox(
                            width: mQ.width / 10,
                            child: CustomDropdown(
                              rowsData: rowData,
                            )));
                      } else if (colIndex == 3) {
                        return DataCell(
                            Padding(
                          padding: EdgeInsets.only(left: Insets.s15d5),
                          child: Container(
                            color: colorTheme.onPrimary,
                            height: mQ.width / 6,
                            width: 1,
                          ),
                        )
                            // }),
                            );
                      } else {
                        return DataCell(Container(
                          height: mQ.height / 5,
                          width: mQ.width / 13.5,
                          padding: EdgeInsets.only(
                              left: Insets.s2,
                              right: Insets.s12,
                              top: Insets.s18,
                              bottom: Insets.s4),
                          margin: EdgeInsets.all(Insets.s4),
                          decoration: BoxDecoration(
                              color: colorTheme.onPrimaryContainer,
                              border: Border.all(
                                  width: 1, color: colorTheme.onPrimary),
                              borderRadius: BorderRadius.circular(3)),
                          child: (colIndex == 1)
                              ? Text(rowData.totalYF.toString())
                              : Text(rowData.totalYTD),
                        ));
                      }
                    }),
                  )))
              .toList()
          : (widget.headingText == Labels.resourceCostHeading)
            ? provider.dashboardAndProjectResourcesCostData.sublist(0,provider.visibleRowCount)
          .map((resourceCostRowData) =>  DataRow(
        cells: List.generate(MasterData.dashboardAndProjectTotalColumnTitles.length,
                (colIndex) {
              if (colIndex == 0) {
                return DataCell(SizedBox(
                    width: mQ.width / 11.8,
                    child: Text(
                      resourceCostRowData.label,
                      style: (isAndroid)
                          ? textTheme.titleMedium!
                          .copyWith(fontSize: FontSizes.s7)
                          : (isMonitor || isLaptop)
                          ? textTheme.titleMedium!.copyWith(
                        fontSize: FontSizes.s18,
                      )
                          : (isTablet)
                          ?textTheme.titleMedium!.copyWith(
                        fontSize: FontSizes.s12,
                      )
                          : textTheme.titleMedium!.copyWith(
                        fontSize: FontSizes.s10,
                      ),
                      textAlign: TextAlign.left,
                    )));
              } else if (colIndex == 3) {
                return DataCell(Padding(
                  padding: EdgeInsets.only(left: Insets.s15d5),
                  child: Center(
                    child: Container(
                      color: colorTheme.onPrimary,
                      height: 160,
                      width: 1,
                    ),
                  ),
                ));
              } else {
                return DataCell(Container(
                  height: mQ.height / 5,
                  width: mQ.width / 13.5,
                  padding: EdgeInsets.only(
                      left: Insets.s2,
                      right: Insets.s12,
                      top: Insets.s18,
                      bottom: Insets.s4),
                  margin:  EdgeInsets.all(Insets.s4),
                  decoration: BoxDecoration(
                      color: colorTheme.onPrimaryContainer,
                      border: Border.all(width: 1, color: colorTheme.onPrimary),
                      borderRadius: BorderRadius.circular(3)),
                  child: (colIndex == 1)
                      ? Text(resourceCostRowData.totalYF
                      .toString())
                      : Text(resourceCostRowData.totalYTD),
                ));
              }
            }),
      )).toList()
           :  provider.dashboardAndProjectMonthBreakdownData
          .mapIndexed((rowIndex, monthBreakdownRowData) => DataRow(
        cells: List.generate(
            MasterData.dashboardAndProjectTotalColumnTitles
                .length, (colIndex) {
          if (colIndex == 0) {
            return DataCell( monthBreakdownRowData.isDottedLine  //(rowIndex == 5 || rowIndex == 7)
                ? const CustomDottedLine()
                : SizedBox(
                width: deviceWidth / 10,
                child: Text(monthBreakdownRowData.label,
                  style: namesTextStyle,
                  textAlign: (isAndroid)
                      ? TextAlign.left
                      : TextAlign.start,
                )));
          }
          else if (colIndex == 3 && monthBreakdownRowData.isSelectIconHide /*rowIndex == 6*/)
          {
            return DataCell(
              Center(
                child: Container(
                  margin:
                      EdgeInsets.only(left: Insets.s15),
                  color: kGrey,
                  width: 1,
                ),
              ),
            );
          }
          else if (colIndex == 3)
          {
            return DataCell(monthBreakdownRowData.isDottedLine//(rowIndex == 5 || rowIndex == 7)
                ? Stack(children: [
              const Center(child: CustomDottedLine()),
              Center(
                child: Container(
                  width: 1,
                  color: colorTheme.onPrimary,
                  margin: monthBreakdownRowData.isDottedLine //rowIndex == 7
                      ? EdgeInsets.only(
                      // bottom: Insets.s24,
                      left: (!projectsProvider.toMoveNavigator)
                          ? Insets.s15
                          : 0)
                      : (!projectsProvider.toMoveNavigator)
                      ? EdgeInsets.only(
                      left: Insets.s15)
                      : null,
                ),
              )
            ])
                :
            Stack(alignment: Alignment.center, children: [
              Container(
                margin: (!projectsProvider.toMoveNavigator)
                    ? EdgeInsets.only(left: Insets.s15d5)
                    : (monthBreakdownRowData.label == 'Monthly Deviation')
                    ?EdgeInsets.only(left: Insets.s15d5):null,
                color: colorTheme.onPrimary,
                height: deviceHeight / 10,
                width: 1,
              ),
              Consumer<DashboardProvider>(
                builder: (context, provider, child) {
                  return MouseRegion(
                    onEnter: (PointerEnterEvent event) {
                      monthBreakdownRowData.onEnterSelectMonthIcon();
                    },
                    onExit: (PointerExitEvent event) {
                      monthBreakdownRowData.onExitSelectMonthIcon();
                    },
                    child: (projectsProvider.toMoveNavigator)
                        ? Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: kBlack
                                .withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset:
                            const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: GestureDetector(
                        onTap: () {
                          monthBreakdownRowData.selectRow();
                        },
                        child: (monthBreakdownRowData.label!='Monthly Deviation')? CircleAvatar(
                          backgroundColor: monthBreakdownRowData.isTotalSelected
                              ? colorTheme.primary
                              : monthBreakdownRowData.selectRowMonth
                              ? colorTheme.primary
                              : colorTheme
                              .secondary,
                          foregroundColor:
                          colorTheme.secondary,
                          radius: 16,
                          child: (monthBreakdownRowData.isTotalSelected)
                              ? SvgPicture.asset(
                              Images.checkIcon)
                              : SvgPicture.asset(Images
                              .editSelectIcon),
                        ):const SizedBox.shrink(),
                      ),
                    )
                        : null,
                  );
                },
              ),
            ]));
          }
          else if (monthBreakdownRowData.isDottedLine // rowIndex == 5 || rowIndex == 7
          ) {
            return const DataCell(CustomDottedLine());
          }
          else
          {
            return DataCell(Container(
              height: deviceHeight / 10,
              width: deviceWidth / 13.5,
              margin: EdgeInsets.only(
                  left: Insets.s4,
                  top: Insets.s4,
                  bottom: Insets.s4,
                  right: Insets.s4),
              decoration: BoxDecoration(
                  color: colorTheme.onPrimaryContainer,
                  border: Border.all(
                      width: 1, color: colorTheme.onPrimary),
                  borderRadius: BorderRadius.circular(3)),
              child: Consumer<DashboardProvider>(
                builder: (context, provider, child) {
                  return Padding(
                    padding: EdgeInsets.only(
                        left: Insets.s2,
                        right: Insets.s12,
                        top: Insets.s18,
                        bottom: Insets.s4),
                    child: (colIndex == 1)
                        ? Text(monthBreakdownRowData.totalYF)
                        : Text(monthBreakdownRowData.totalYTD),
                  );
                },
              ),
            ));
          }
        }),
      )).toList()
    );
  }
}
