
import 'package:ddofinance/providers/dashboard/dashboard_provider.dart';
import 'package:ddofinance/screens/dashBoard/custom_text_form_field.dart';
import 'package:ddofinance/theme/color_constants.dart';
import 'package:ddofinance/theme/styles.dart';
import 'package:ddofinance/utils/constants/labels.dart';
import 'package:ddofinance/utils/device_screens/device_info.dart';
import 'package:ddofinance/utils/master_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

List<DataRow> resourceMonthDataRows = List.generate(
  6,
  (rowIndex) => DataRow(
    cells: List.generate(MasterData.dashboardAndProjectMonthColumnsNames.length,
        (colIndex) {
      return DataCell(
        Builder(builder: (context) {
          var mQ = MediaQuery.of(context).size;
          final theme = Theme.of(context);
          final bool isAndroid = DeviceOS.isAndroid;
          final bool isMonitor = DeviceScreen.isMonitor(context);
          final bool isLaptop = DeviceScreen.isLargeScreen(context);
          var resourceMonthFocusNode = FocusNode();
          var provider = Provider.of<DashboardProvider>(context,);
          return Container(
              height: mQ.height / 5,
              width: mQ.width / 11.6,
              margin: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                  color: kLightGreyShade,
                  border: Border.all(
                      color: provider.isValidResourcesCost[
                      rowIndex][colIndex]
                          ? kRed
                          : kGrey,
                      width: (provider.isValidResourcesCost[
                      rowIndex]
                      [colIndex])
                          ? 1.5
                          : 1),
                  borderRadius:
                  BorderRadius.circular(5)),
              child: CustomTextFormField(
                rowIndex: rowIndex,
                cellIndex: colIndex,
                textFormFieldName: Labels.resourceMonthTextField,
                rowLength: 6,
                colLength: MasterData.dashboardAndProjectMonthColumnsNames.length,
              ));
        }),
      );
    }),
    // selected: isSelected[rowIndex],
  ),
);

List<DataRow> resourceTotalDataRows = List.generate(
  6,
  (rowIndex) => DataRow(
    cells: List.generate(MasterData.dashboardAndProjectTotalColumnTitles.length,
        (colIndex) {
      if (colIndex == 0) {
        return DataCell(Builder(builder: (context) {
          var mQ = MediaQuery.of(context).size;
          final theme = Theme.of(context);
          final bool isAndroid = DeviceOS.isAndroid;
          final bool isMonitor = DeviceScreen.isMonitor(context);
          final bool isLaptop = DeviceScreen.isLargeScreen(context);
          final bool isTablet = DeviceScreen.isTablet(context);
          return SizedBox(
              width: mQ.width / 11.8,
              child: Text(
                MasterData.dashboardAndProjectResourcesCost[rowIndex],
                style: (isAndroid)
                    ? theme.textTheme.titleMedium!
                        .copyWith(fontSize: FontSizes.s7)
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
                              ),
                textAlign: TextAlign.left,
              ));
        }));
      } else if (colIndex == 3 && rowIndex == 6) {
        return DataCell(
          Center(
            child: Builder(builder: (context) {
              return Container(
                color: kGrey,
                width: 1,
              );
            }),
          ),
        );
      } else if (colIndex == 3) {
        return DataCell(Padding(
          padding: const EdgeInsets.only(left: 15.5),
          child: Center(
            child: Builder(builder: (context) {
              return Container(
                color: kGrey,
                height: 160,
                width: 1,
              );
            }),
          ),
        ));
      } else {
        return DataCell(Builder(builder: (context) {
          var mQ = MediaQuery.of(context).size;
          final theme = Theme.of(context);
          final bool isAndroid = DeviceOS.isAndroid;
          final bool isMonitor = DeviceScreen.isMonitor(context);
          final bool isLaptop = DeviceScreen.isLargeScreen(context);
          final DashboardProvider provider =
              Provider.of<DashboardProvider>(context, listen: false);
          return Container(
            height: mQ.height / 5,
            width: mQ.width / 11.6,
            padding: EdgeInsets.only(
                left: Insets.s2,
                right: Insets.s12,
                top: Insets.s18,
                bottom: Insets.s4),
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(
                color: kLightGreyShade,
                border: Border.all(width: 1, color: kGrey),
                borderRadius: BorderRadius.circular(5)),
            child: (colIndex == 1)
                ? Text(MasterData
                    .dashboardAndProjectResourceTotalFYValue[rowIndex]
                    .toString())
                : Text(MasterData
                    .dashboardAndProjectResourceTotalYTDValue[rowIndex]),
          );
        }));
      }
    }),
  ),
);
