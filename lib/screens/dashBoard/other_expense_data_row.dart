import 'package:ddofinance/providers/dashboard/dashboard_provider.dart';
import 'package:ddofinance/screens/dashBoard/custom_text_form_field.dart';
import 'package:ddofinance/theme/color_constants.dart';
import 'package:ddofinance/theme/styles.dart';
import 'package:ddofinance/utils/constants/labels.dart';
import 'package:ddofinance/utils/master_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'custom_drop_down.dart';




Future<void> saveOtherExpenseLength(int expenseMonthDataRows, BuildContext context) async {
  var prefs = await SharedPreferences.getInstance();
  prefs.setInt('ExpenseMonthDataRows', expenseMonthDataRows);
  getExpenseMonthDataRowsLength();
}

Future<void> getExpenseMonthDataRowsLength() async {
  var prefs = await SharedPreferences.getInstance();
  MasterData.expenseMonthDataRows = prefs.getInt('ExpenseMonthDataRows')!;
}

List<DataRow> dashboardAndProjectExpenseMonthDataRows = List.generate(
  2,
  (rowIndex) => DataRow(
    cells: List.generate(MasterData
        .dashboardAndProjectMonthlyData[0].monthValues!.length,
        (colIndex) {
      return DataCell(
        Builder(
          builder: (context) {
            var mQ = MediaQuery.of(context).size;
            final DashboardProvider provider =
                Provider.of<DashboardProvider>(context, listen: true);
            return Container(
                height: mQ.height / 5,
                width: mQ.width / 13.5,
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                    color: kLightGreyShade,
                    border: Border.all(
                        color: provider.isValidOtherExpense[rowIndex][colIndex]
                            ? kRed
                            : kGrey,
                        width: (provider.isValidOtherExpense[rowIndex]
                        [colIndex])
                            ? 1.5
                            : 1),
                    borderRadius: BorderRadius.circular(3)),
                child: CustomTextFormField(
                  rowIndex: rowIndex,
                  cellIndex: colIndex,
                  textFormFieldName: Labels.expenseMonthTextField,
                  rowLength: 2,
                  colLength: MasterData
                      .dashboardAndProjectMonthlyData[0].monthValues!.length,
                ));
          },
        ),
      );
    }),
    // selected: isSelected[rowIndex],
  ),
);

List<DataRow> dashboardAndProjectExpenseTotalDataRows = List.generate(
  2,
  (rowIndex) => DataRow(
    cells: List.generate(MasterData.dashboardAndProjectTotalColumnTitles.length,
        (colIndex) {
      if (colIndex == 0) {
        return DataCell(Builder(builder: (context) {
          var mQ = MediaQuery.of(context).size;
          var provider= Provider.of<DashboardProvider>(context);
          return SizedBox(
              width: mQ.width / 10,
              child: provider.dashboardAndProjectExpenseDropdownList[rowIndex]
          );
        }));
      } else if (colIndex == 3) {
        return DataCell(
          Builder(builder: (context) {
            var mQ = MediaQuery.of(context).size;
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
          var provider = Provider.of<DashboardProvider>(context, listen: false);
          return Container(
            height: mQ.height / 5,
            width: mQ.width / 13.5,
            padding: EdgeInsets.only(
                left: Insets.s2,
                right: Insets.s12,
                top: Insets.s18,
                bottom: Insets.s4),
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(
                color: kLightGreyShade,
                border: Border.all(width: 1, color: kGrey),
                borderRadius: BorderRadius.circular(3)),
            child: (colIndex == 1)
                ? Text(provider.dashboardAndProjectExpenseTotalFYValue[rowIndex]
                .toString())
                : Text(provider.dashboardAndProjectExpenseTotalYTDValue[rowIndex]),
          );
        }));
      }
    }),
  ),
);
