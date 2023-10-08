import 'package:ddofinance/providers/dashboard/dashboard_provider.dart';
import 'package:ddofinance/screens/dashBoard/custom_text_form_field.dart';
import 'package:ddofinance/theme/color_constants.dart';
import 'package:ddofinance/theme/styles.dart';
import 'package:ddofinance/utils/constants/labels.dart';
import 'package:ddofinance/utils/device_screens/device_info.dart';
import 'package:ddofinance/utils/master_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'custom_drop_down.dart';

int rowsLength = 2;

List<DataRow> dashboardAndProjectExpenseMonthDataRows = List.generate(
  rowsLength,
  (rowIndex) => DataRow(
    cells: List.generate(MasterData.dashboardAndProjectMonthColumnsNames.length,
        (colIndex) {
      return DataCell(
        Builder(
          builder: (context) {
            var mQ = MediaQuery.of(context).size;
            final theme = Theme.of(context);
            final bool isAndroid = DeviceOS.isAndroid;
            final bool isMonitor = DeviceScreen.isMonitor(context);
            final bool isLaptop = DeviceScreen.isLargeScreen(context);
            final bool isTablet = DeviceScreen.isTablet(context);
            final DashboardProvider provider =
                Provider.of<DashboardProvider>(context, listen: true);
            var expenseFocusNode = FocusNode();
            return Container(
                height: mQ.height / 5,
                width: mQ.width / 11.6,
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                    color: kLightGreyShade,
                    border: Border.all(
                        color: provider.isValidOtherExpense[
                        rowIndex][colIndex]
                            ? kRed
                            : kGrey,
                        width: (provider.isValidOtherExpense[
                        rowIndex]
                        [colIndex])
                            ? 1.5
                            : 1),
                    borderRadius:
                    BorderRadius.circular(5)),
                child: CustomTextFormField(
                  rowIndex: rowIndex,
                  cellIndex: colIndex,
                  textFormFieldName: Labels.expenseMonthTextField,
                  rowLength: 2,
                  colLength: MasterData.dashboardAndProjectMonthColumnsNames.length,
                ));
          },
        ),
      );
    }),
    // selected: isSelected[rowIndex],
  ),
);

List<DataRow> dashboardAndProjectExpenseTotalDataRows = List.generate(
  rowsLength,
  (rowIndex) => DataRow(
    cells: List.generate(MasterData.dashboardAndProjectTotalColumnTitles.length,
        (colIndex) {
      if (colIndex == 0) {
        return DataCell(Builder(builder: (context) {
          var mQ = MediaQuery.of(context).size;
          return SizedBox(
              width: mQ.width / 10,
              child: CustomDropdown(
                index: rowIndex,
              ));
        }));
      } else if (colIndex == 3) {
        return DataCell(
          Builder(builder: (context) {
            var mQ = MediaQuery.of(context).size;
            final theme = Theme.of(context);
            return Padding(
              padding: const EdgeInsets.only(left: 15.5),
              child: Container(
                color: kGrey,
                height: mQ.width / 6,
                width: 1,
              ),
            );
          }),
        );
      } else {
        return DataCell(Builder(builder: (context) {
          var mQ = MediaQuery.of(context).size;
          final theme = Theme.of(context);
          final bool isAndroid = DeviceOS.isAndroid;
          final bool isMonitor = DeviceScreen.isMonitor(context);
          final bool isLaptop = DeviceScreen.isLargeScreen(context);
          final bool isTablet = DeviceScreen.isTablet(context);
          var expenseTotalFocusNode = FocusNode();
          var provider = Provider.of<DashboardProvider>(context, listen: false);
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
                ? Text(provider.dashboardAndProjectExpenseTotalFYValue[rowIndex]
                    .toString())
                : Text(
                provider.dashboardAndProjectExpenseTotalYTDValue[rowIndex]),
          );
        }));
      }
    }),
  ),
);
