import 'package:ddofinance/models/dashboard/add_row_other_expense.dart';
import 'package:ddofinance/models/dashboard/other_expenses.dart';
import 'package:ddofinance/models/dropdown.dart';
import 'dart:math';
import 'package:ddofinance/models/dashboard/dashboard_project_dropdown.dart';
import 'package:ddofinance/providers/projects/projects_provider.dart';
import 'package:ddofinance/screens/dashBoard/custom_drop_down.dart';
import 'package:ddofinance/screens/dashBoard/custom_text_form_field.dart';
import 'package:ddofinance/screens/dashBoard/other_expense_data_row.dart';
import 'package:ddofinance/theme/color_constants.dart';
import 'package:ddofinance/theme/styles.dart';
import 'package:ddofinance/utils/constants/labels.dart';
import 'package:ddofinance/utils/device_screens/device_info.dart';
import 'package:ddofinance/utils/master_data.dart';
import 'package:ddofinance/utils/validators.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../repository/dashboard/drop_down.dart';

///A provider class used for dashboard details.
class DashboardProvider extends ChangeNotifier {
  /// Dash Board Data

  late Map<String, List<DropDownModel>> dropDownData;
  List<DropDownModel> dropDownData1 = [];
  List<DropDownModel> dropDownData2 = [];
  List<DropDownModel> dropDownData3 = [];
  List<DropDownModel> dropDownData4 = [];

  String? selectedValue = 'Item 1';

  void addingDropDownValues() async {
    dropDownData = await DropDownRepository().dropDownRepository();
    dropDownData1 = dropDownData['result 1']!;
    dropDownData2 = dropDownData['result 2']!;
    dropDownData3 = dropDownData['result 3']!;
    dropDownData4 = dropDownData['result 4']!;
    notifyListeners();
  }

  void setValue(String value) {
    selectedValue = value;
    notifyListeners();
  }

  /// Common methods for all Data Table

  List<double> dashboardAndProjectMonthTotalFYValue =
      List.filled(MasterData.dashboardAndProjectMonthRowNames.length, 0);

  List<String> dashboardAndProjectMonthTotalYTDValue = List.generate(
      MasterData.dashboardAndProjectMonthRowNames.length, (_) => '0');

  List<List<String>> dashboardAndProjectMonthTextValue = List.generate(
      MasterData.dashboardAndProjectMonthRowNames.length,
      (rowIndex) => List<String>.generate(
          MasterData.dashboardAndProjectMonthlyData[0].monthValues!.length,
          (cellIndex) => '0'));

  // Validation of all Data Cells
  final List<List<bool>> isValidMonthBreakdown = List.generate(
      MasterData.dashboardAndProjectMonthRowNames.length,
      (_) => List.filled(
          MasterData.dashboardAndProjectMonthlyData[0].monthValues!.length,
          false));

  final List<List<bool>> isValidOtherExpense = List.generate(
      dashboardAndProjectExpenseMonthDataRows.length,
      (_) => List.filled(
          MasterData.dashboardAndProjectMonthlyData[0].monthValues!.length,
          false));



  final List<List<bool>> isValidResourcesCost = List.generate(
      6,
      (_) => List.filled(
          MasterData.dashboardAndProjectMonthlyData[0].monthValues!.length,
          false));

  void showValidation(
      String value, int rowIndex, int colIndex, String textField) {
    if (textField == Labels.monthBreakdownTextField) {
      if (TextFieldValidation.validateInput(value) == '!') {
        isValidMonthBreakdown[rowIndex][colIndex] = true;
      } else {
        isValidMonthBreakdown[rowIndex][colIndex] = false;
      }
    }
    if (textField == Labels.expenseMonthTextField) {
      if (TextFieldValidation.validateInput(value) == '!') {
        isValidOtherExpense[rowIndex][colIndex] = true;
      } else {
        isValidOtherExpense[rowIndex][colIndex] = false;
      }
    }
    if (textField == Labels.resourceMonthTextField) {
      if (TextFieldValidation.validateInput(value) == '!') {
        isValidResourcesCost[rowIndex][colIndex] = true;
      } else {
        isValidResourcesCost[rowIndex][colIndex] = false;
      }
    }
    if (textField == Labels.addRowExpenseMonthTextField) {
      if (TextFieldValidation.validateInput(value) == '!') {
        isValidAddRowExpenseCost[rowIndex][colIndex] = true;
      } else {
        isValidAddRowExpenseCost[rowIndex][colIndex] = false;
      }
      notifyListeners();
    }
  }

  /// Month By Month Break Down Data Table
  //Initialising and Updating data from Local Storage
  // List localData = [];

  // void updateCellValue(String value, int rowIndex, int cellIndex) {
  //   (rowIndex == 0)
  //       ? (localData[rowIndex].forecastedRevenue[cellIndex] = value)
  //       : (rowIndex == 1)
  //           ? (localData[rowIndex].actualRevenue[cellIndex] = value)
  //           : (rowIndex == 2)
  //               ? (localData[rowIndex].forecastedCollection[cellIndex] = value)
  //               : (rowIndex == 3)
  //                   ? (localData[rowIndex].actualCollection[cellIndex] = value)
  //                   : (rowIndex == 4)
  //                       ? (localData[rowIndex].monthlyCost[cellIndex] = value)
  //                       : (rowIndex == 5)
  //                           ? (rowIndex == 6)
  //                               ? (localData[rowIndex].dottedLine1[cellIndex] =
  //                                   value)
  //                               : (localData[rowIndex]
  //                                   .monthlyDeviation[cellIndex] = value)
  //                           : (localData[rowIndex].dottedLine2[cellIndex] ==
  //                               value);
  //   (rowIndex == 0)
  //       ? (dashboardAndProjectMonthTextValue[rowIndex][cellIndex] = value)
  //       : (rowIndex == 1)
  //           ? (dashboardAndProjectMonthTextValue[rowIndex][cellIndex] = value)
  //           : (rowIndex == 2)
  //               ? (dashboardAndProjectMonthTextValue[rowIndex][cellIndex] =
  //                   value)
  //               : (rowIndex == 3)
  //                   ? (dashboardAndProjectMonthTextValue[rowIndex][cellIndex] =
  //                       value)
  //                   : (rowIndex == 4)
  //                       ? (dashboardAndProjectMonthTextValue[rowIndex]
  //                           [cellIndex] = value)
  //                       : (rowIndex == 5)
  //                           ? (rowIndex == 6)
  //                               ? (dashboardAndProjectMonthTextValue[rowIndex]
  //                                   [cellIndex] = value)
  //                               : (dashboardAndProjectMonthTextValue[rowIndex]
  //                                   [cellIndex] = value)
  //                           : (dashboardAndProjectMonthTextValue[rowIndex]
  //                                   [cellIndex] ==
  //                               value);
  // }

  //Comment Box
  double boxPositionX = 0;
  double boxPositionY = 0;
  bool toggleCommentBox = false;

  void openCommentBox(BuildContext context, TapDownDetails details,
      int rowIndex, int cellIndex) {
    commentRowIndex = rowIndex;
    commentColumnIndex = cellIndex;
    final bool isMonitor = DeviceScreen.isMonitor(context);
    final bool isLaptop = DeviceScreen.isLargeScreen(context);
    final bool isTablet = DeviceScreen.isTablet(context);
    final RenderBox box = context.findRenderObject() as RenderBox;
    final Offset localOffset = box.globalToLocal(details.globalPosition);
    toggleCommentBox = true;
    boxPositionX = (isMonitor)
        ? localOffset.dx + 496
        : (isLaptop)
            ? localOffset.dx + 440
            : (isTablet)
                ? localOffset.dx + 238
                : localOffset.dx + 235;
    boxPositionY = (isMonitor)
        ? localOffset.dy - 28
        : (isLaptop)
            ? (!Provider.of<ProjectsProvider>(context, listen: false).toMove)
                ? localOffset.dy - 8
                : localOffset.dy - 35
            : (isTablet)
                ? localOffset.dy - 20
                : localOffset.dy - 20;
    notifyListeners();
  }

  void closeCommentBox() {
    toggleCommentBox = false;
    notifyListeners();
  }

  // hovering on each Container for Icons.
  final List<List<bool>> monthBlock = List.generate(
      MasterData.dashboardAndProjectMonthRowNames.length,
      (_) => List.filled(
          MasterData.dashboardAndProjectMonthlyData[0].monthValues!.length,
          false));

  void enterMonthBlock(PointerEnterEvent event, int colIndex, int rowIndex) {
    monthBlock[rowIndex][colIndex] = true;
    notifyListeners();
  }

  void exitMonthBlock(PointerExitEvent event, int colIndex, int rowIndex) {
    monthBlock[rowIndex][colIndex] = false;
    notifyListeners();
  }

  //hovering on Icons for comment Box.
  late int commentRowIndex;
  late int commentColumnIndex;

  final List<List<String>> commentMessage = List.generate(
      8,
      (rowIndex) => List.generate(
          MasterData.dashboardAndProjectMonthlyData[0].monthValues!.length,
          (cellIndex) => '$rowIndex and $cellIndex}'));

  final List<List<bool>> monthIcon = List.generate(
      MasterData.dashboardAndProjectMonthRowNames.length,
      (_) => List.filled(
          MasterData.dashboardAndProjectMonthlyData[0].monthValues!.length,
          false));

  void enterMonthIcon(PointerEnterEvent event, int colIndex, int rowIndex) {
    monthIcon[rowIndex][colIndex] = true;
    notifyListeners();
  }

  void exitMonthIcon(PointerExitEvent event, int colIndex, int rowIndex) {
    monthIcon[rowIndex][colIndex] = false;
    notifyListeners();
  }

  // Moving the cursor in month Data Table.

  // Hovering on Selects Icons
  final List<bool> selectRowMonth = List.filled(
      MasterData.dashboardAndProjectMonthlyData[0].monthValues!.length, false);
  void onEnterSelectMonthIcon(PointerEnterEvent event, int index) {
    selectRowMonth[index] = !selectRowMonth[index];
    notifyListeners();
  }

  void onExitSelectMonthIcon(PointerExitEvent details, int index) {
    selectRowMonth[index] = false;
    notifyListeners();
  }

  final List<bool> isSelected = List<bool>.generate(
      MasterData.dashboardAndProjectMonthRowNames.length, (int index) => false);

  final List<bool> isSelect = List<bool>.generate(
      MasterData.dashboardAndProjectMonthRowNames.length, (int index) => false);

  void selectRow(int index) {
    isSelected[index] = !isSelected[index];
    isSelect[index] = isSelected[index];
    notifyListeners();
  }

  // Adding the Data into the Total FY column.
  late List<List<TextEditingController>> monthBreakdownTextController;
  late List<List<TextEditingController>> otherExpenseTextController;
  late List<List<TextEditingController>> resourceCostTextController;
  late List<List<TextEditingController>> addRowOtherExpenseTextController;

  List<List<String>> dashboardAndProjectExpenseMonthValue = List.generate(
      MasterData.dashboardAndProjectMonthRowNames.length,
      (rowIndex) => List<String>.generate(
          MasterData.dashboardAndProjectMonthlyData[0].monthValues!.length,
          (cellIndex) => '0'));

  // List<List<String>> dashboardAndProjectAddRowExpenseMonthValue = List.generate(
  //     6,
  //     (rowIndex) => List.generate(
  //         MasterData.dashboardAndProjectMonthlyData[0].monthValues!.length,
  //         (cellIndex) => '0'));

  void calculateSum(
      String value, int rowLength, int columnLength, String textField) {
    if (textField == Labels.monthBreakdownTextField) {
      for (int rowIndex = 0; rowIndex < rowLength; rowIndex++) {
        double sum = 0;
        for (int colIndex = 0; colIndex < columnLength; colIndex++) {
          sum += double.tryParse(
                  monthBreakdownTextController[rowIndex][colIndex].text) ??
              0;
        }
        dashboardAndProjectMonthTotalFYValue[rowIndex] = sum;
      }
    }
    if (textField == Labels.expenseMonthTextField) {
      for (int rowIndex = 0; rowIndex < rowLength; rowIndex++) {
        double sum = 0;
        for (int colIndex = 0; colIndex < columnLength; colIndex++) {
          sum += double.tryParse(
                  otherExpenseTextController[rowIndex][colIndex].text) ??
              0;
        }
        dashboardAndProjectExpenseTotalFYValue[rowIndex] = sum;
      }
    }
    if (textField == Labels.resourceMonthTextField) {
      for (int rowIndex = 0; rowIndex < rowLength; rowIndex++) {
        double sum = 0;
        for (int colIndex = 0; colIndex < columnLength; colIndex++) {
          sum += double.tryParse(
                  resourceCostTextController[rowIndex][colIndex].text) ??
              0;
        }
        dashboardAndProjectExpenseTotalFYValue[rowIndex] = sum;
      }
    }
    notifyListeners();
  }

  /// Other Expense Data Table
  //Table Dropdown
  String searchQuery = '';
  double _dropDownPositionX = 0;
  double _dropDownPositionY = 0;
  get getDropDownPositionX => _dropDownPositionX;
  get getDropDownPositionY => _dropDownPositionY;
  set setDropDownPositionX(double x) => _dropDownPositionX = x;
  set setDropDownPositionY(double y) => _dropDownPositionY = y;

  List<CustomDropdown> dashboardAndProjectExpenseDropdownList = [
    CustomDropdown(
      index: 0,
      selectedValue: '0',
    ),
    CustomDropdown(
      index: 1,
      selectedValue: '0',
    ),
  ];

  List<OtherExpenseModel> addRowOtherExpenseList = [];

  List<double> dashboardAndProjectExpenseTotalFYValue = List.generate(
      2,
      (_) => 0);

  List<String> dashboardAndProjectExpenseTotalYTDValue = List.generate(
      2,
      (_) => '0');
  final List<bool> isDropdownIndexOpen = [false,false];

  List<String> dropDownInitialValue = ['Food', 'Food'];

  int dropdownIndex = 0;
  void showingDropDown(TapDownDetails details, BuildContext context, int index,
      GlobalKey widgetKey) {
    final bool isMonitor = DeviceScreen.isMonitor(context);
    final bool isLaptop = DeviceScreen.isLargeScreen(context);
    RenderBox renderBox =
        widgetKey.currentContext?.findRenderObject() as RenderBox;
    Offset widgetPosition = renderBox.localToGlobal(Offset.zero);
    _dropDownPositionX =
        (isMonitor) ? widgetPosition.dy + 30 : widgetPosition.dy - 25;
    _dropDownPositionY = (isMonitor)
        ? widgetPosition.dx - 130
        : (isLaptop)
            ? widgetPosition.dx - 313
            : widgetPosition.dx - 35;
    isDropdownIndexOpen[index] = !isDropdownIndexOpen[index];
    dropdownIndex = index;
    // print(index);
    notifyListeners();
  }

  void selectOption(String option, int index) {
    dropDownInitialValue[index] = option;
    isDropdownIndexOpen[dropdownIndex] = false;
    notifyListeners();
  }

  // int filterListIterator = 0;
  // List<DashboardAndProjectDropdown> getFilteredOptions() {
  //   filterListIterator++;
  //   return MasterData.dashboardAndProjectDropdownData.where((option) {
  //     return option.label.toLowerCase().contains(searchQuery.toLowerCase());
  //   }).toList();
  // }

  // Adding the row in the List in Other expenses data table.
  List<AddRowOtherExpenseModel> addRowMapData = [{
    "label": "Food",
    "monthValues": [
      {
        "label": "apr",
        "value": 1
      },
      {
        "label": "May",
        "value": 2
      },
      {
        "label": "Jun",
        "value": 3
      },
      {
        "label": "Jul",
        "value": 4
      },
      {
        "label": "Aug",
        "value": 5
      },
      {
        "label": "Sept",
        "value": 6
      },
      {
        "label": "Oct",
        "value": 7
      },
      {
        "label": "Nov",
        "value": 8
      },
      {
        "label": "Dec",
        "value": 9
      },
      {
        "label": "Jan",
        "value": 10
      },
      {
        "label": "Feb",
        "value": 11
      },
      {
        "label": "Mar",
        "value": 12
      }
    ]}].map((e) => AddRowOtherExpenseModel.fromJson(e)).toList();

  List<AddRowOtherExpenseModel> addRowOtherExpenseData = MasterData.addRowOtherExpenseJSONData
      .map((e) => AddRowOtherExpenseModel.fromJson(e))
      .toList();

  int addRowIndex = 1;
  final List<List<bool>> isValidAddRowExpenseCost = List.generate(
      dashboardAndProjectExpenseMonthDataRows.length,
          (_) => List.filled(
          MasterData.dashboardAndProjectMonthlyData[0].monthValues!.length,
          false));
  void addRowExpenseDatatable(BuildContext context) {
    var mQ = MediaQuery.of(context).size;
    DataRow newTotalRow = DataRow(
      cells: List.generate(
          MasterData.dashboardAndProjectTotalColumnTitles.length, (colIndex) {
        if (colIndex == 0) {
          return DataCell(SizedBox(
              width: mQ.width / 10,
              child: dashboardAndProjectExpenseDropdownList[addRowIndex]));
        } else if (colIndex == 3) {
          return DataCell(
            Padding(
              padding: const EdgeInsets.only(left: 15.5),
              child: Container(
                color: kGrey,
                height: mQ.height / 4.3,
                width: 1,
              ),
            ),
          );
        } else {
          return DataCell(Container(
              height: mQ.height / 3.5,
              width: mQ.width / 13.5,
              margin: EdgeInsets.all(Insets.s4),
              padding: EdgeInsets.only(
                  left: Insets.s2,
                  right: Insets.s12,
                  top: Insets.s18,
                  bottom: Insets.s4),
              decoration: BoxDecoration(
                  color: kLightGreyShade,
                  border: Border.all(width: 1, color: kGrey),
                  borderRadius: BorderRadius.circular(3)),
              child: (colIndex == 1)
                  ? Text(dashboardAndProjectExpenseTotalFYValue[addRowIndex]
                      .toString())
                  : Text(
                      dashboardAndProjectExpenseTotalYTDValue[addRowIndex])));
        }
      }),
    );
    DataRow newMonthRow = DataRow(
      cells: List.generate(
          MasterData.dashboardAndProjectMonthlyData[0].monthValues!.length,
          (colIndex) {
        return DataCell(
          Container(
              height: mQ.height / 3.5,
              width: mQ.width / 13.5,
              margin: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                  color: kLightGreyShade,
                  border: Border.all(
                      color:isValidAddRowExpenseCost[addRowIndex][colIndex]
                          ? kRed
                         :
                      kGrey,
                      width: // (isValidAddRowExpenseCost[addRowIndex][colIndex])
                          //? 1.5
                      //    :
                      1),
                  borderRadius: BorderRadius.circular(3)),
              child: CustomTextFormField(
                rowIndex: addRowIndex,
                cellIndex: colIndex,
                textFormFieldName: Labels.addRowExpenseMonthTextField,
                rowLength: addRowOtherExpenseData.length,
                colLength: MasterData
                    .dashboardAndProjectMonthlyData[0].monthValues!.length,
              )),
        );
      }),
      // selected: isSelected[rowIndex],
    );
    dashboardAndProjectExpenseMonthDataRows.add(newMonthRow);
    dashboardAndProjectExpenseTotalDataRows.add(newTotalRow);
    notifyListeners();
  }

  /// Resource Data Table

  int visibleRowCount = 3;
  void showMoreRows() {
    visibleRowCount += 3;
    notifyListeners();
  }
}
