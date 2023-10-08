import 'package:ddofinance/providers/projects/projects_provider.dart';
import 'package:ddofinance/screens/dashBoard/custom_drop_down.dart';
import 'package:ddofinance/screens/dashBoard/custom_text_form_field.dart';
import 'package:ddofinance/screens/dashBoard/other_expense_data_row.dart';
import 'package:ddofinance/screens/dashBoard/resource_cost_data_rows.dart';
import 'package:ddofinance/theme/color_constants.dart';
import 'package:ddofinance/theme/styles.dart';
import 'package:ddofinance/utils/constants/labels.dart';
import 'package:ddofinance/utils/device_screens/device_info.dart';
import 'package:ddofinance/utils/master_data.dart';
import 'package:ddofinance/utils/validators.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

///A provider class used for dashboard details.
class DashboardProvider extends ChangeNotifier {
  /// Dash Board Data
  List<String> dropDownItems1 = [
    '2023-2024',
    '2022-2023',
    '2021-2022',
    '2020-2021'
  ];

  List<String> dropDownItems2 = [
    'All',
    'Akshay Srivastava',
    'Atul Srivastava',
    'Prashant Katiyar',
    'Sandeep Gupta'
  ];

  List<String> dropDownItems3 = [
    'All',
    'Strategen',
    'CGC-CPT',
    'AdFactors',
    'ScaledFoundations'
  ];

  List<String> dropDownItems4 = [
    'All',
    'Strategen',
    'CGC-CPT',
    'AdFactors',
    'ScaledFoundations'
  ];

  String? selectedValue = 'Item 1';

  void setValue(String value) {
    selectedValue = value;
    notifyListeners();
  }

  /// Common methods for all Data Table

  List<double> dashboardAndProjectMonthTotalFYValue =
      List.filled(MasterData.dashboardAndProjectMonthRowNames.length, 0);

  List<String> dashboardAndProjectMonthTotalYTDValue = List.generate(
      MasterData.dashboardAndProjectMonthRowNames.length, (_) => '0');

  late List<List<String>> dashboardAndProjectMonthTextValue;

  // Validation of all Data Cells
  final List<List<bool>> isValidMonthBreakdown = List.generate(
      MasterData.dashboardAndProjectMonthRowNames.length,
      (_) => List.filled(
          MasterData.dashboardAndProjectMonthColumnsNames.length, false));

  final List<List<bool>> isValidOtherExpense = List.generate(dashboardAndProjectExpenseMonthDataRows.length,
          (_) => List.filled(
          MasterData.dashboardAndProjectMonthColumnsNames.length, false));

  final List<List<bool>> isValidAddRowExpenseCost = List.generate(dashboardAndProjectExpenseMonthDataRows.length+4,
          (_) => List.filled(
          MasterData.dashboardAndProjectMonthColumnsNames.length, false));

  final List<List<bool>> isValidResourcesCost = List.generate(6,
          (_) => List.filled(
          MasterData.dashboardAndProjectMonthColumnsNames.length, false));






  void showValidation(String value, int rowIndex, int colIndex, String textField) {

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
    }
    notifyListeners();
  }


  /// Month By Month Break Down Data Table
  //Initialising and Updating data from Local Storage
  List localData = [];

  void updateCellValue(String value, int rowIndex, int cellIndex) {
    (rowIndex == 0)
        ? (localData[rowIndex].forecastedRevenue[cellIndex] = value)
        : (rowIndex == 1)
            ? (localData[rowIndex].actualRevenue[cellIndex] = value)
            : (rowIndex == 2)
                ? (localData[rowIndex].forecastedCollection[cellIndex] = value)
                : (rowIndex == 3)
                    ? (localData[rowIndex].actualCollection[cellIndex] = value)
                    : (rowIndex == 4)
                        ? (localData[rowIndex].monthlyCost[cellIndex] = value)
                        : (rowIndex == 5)
                            ? (rowIndex == 6)
                                ? (localData[rowIndex].dottedLine1[cellIndex] =
                                    value)
                                : (localData[rowIndex]
                                    .monthlyDeviation[cellIndex] = value)
                            : (localData[rowIndex].dottedLine2[cellIndex] ==
                                value);
    (rowIndex == 0)
        ? (dashboardAndProjectMonthTextValue[rowIndex][cellIndex] = value)
        : (rowIndex == 1)
            ? (dashboardAndProjectMonthTextValue[rowIndex][cellIndex] = value)
            : (rowIndex == 2)
                ? (dashboardAndProjectMonthTextValue[rowIndex][cellIndex] =
                    value)
                : (rowIndex == 3)
                    ? (dashboardAndProjectMonthTextValue[rowIndex][cellIndex] =
                        value)
                    : (rowIndex == 4)
                        ? (dashboardAndProjectMonthTextValue[rowIndex]
                            [cellIndex] = value)
                        : (rowIndex == 5)
                            ? (rowIndex == 6)
                                ? (dashboardAndProjectMonthTextValue[rowIndex]
                                    [cellIndex] = value)
                                : (dashboardAndProjectMonthTextValue[rowIndex]
                                    [cellIndex] = value)
                            : (dashboardAndProjectMonthTextValue[rowIndex]
                                    [cellIndex] ==
                                value);
  }

  //Comment Box
  double boxPositionX = 0;
  double boxPositionY = 0;
  bool toggleCommentBox = false;

  void openCommentBox(BuildContext context, TapDownDetails details) {
    final bool isMonitor = DeviceScreen.isMonitor(context);
    final bool isLaptop = DeviceScreen.isLargeScreen(context);
    final bool isTablet = DeviceScreen.isTablet(context);
    final RenderBox box = context.findRenderObject() as RenderBox;
    final Offset localOffset = box.globalToLocal(details.globalPosition);
    toggleCommentBox = true;
    boxPositionX = (isMonitor)
        ? localOffset.dx + 496
        : (isLaptop)
            ? localOffset.dx + 478
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
          MasterData.dashboardAndProjectMonthColumnsNames.length, false));

  void enterMonthBlock(PointerEnterEvent event, int colIndex, int rowIndex) {
    monthBlock[rowIndex][colIndex] = true;
    notifyListeners();
  }

  void exitMonthBlock(PointerExitEvent event, int colIndex, int rowIndex) {
    monthBlock[rowIndex][colIndex] = false;
    notifyListeners();
  }

  //hovering on Icons for comment Box.
  final List<List<bool>> monthIcon = List.generate(
      MasterData.dashboardAndProjectMonthRowNames.length,
      (_) => List.filled(
          MasterData.dashboardAndProjectMonthColumnsNames.length, false));
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
      MasterData.dashboardAndProjectMonthColumnsNames.length, false);
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
  late List<List<TextEditingController>> controller1;
  late List<List<TextEditingController>> controller2;
  late List<List<TextEditingController>> controller3;
  late List<List<TextEditingController>> controller4;
  List<double> dashboardAndProjectExpenseTotalFYValue =
      List.generate(MasterData.dashboardAndProjectExpenseList.length, (_) => 0);
  List<String> dashboardAndProjectExpenseTotalYTDValue = List.generate(
      MasterData.dashboardAndProjectExpenseList.length, (_) => '0');
  List<List<String>> dashboardAndProjectExpenseMonthValue = List.generate(
      MasterData.dashboardAndProjectMonthRowNames.length,
      (rowIndex) => List<String>.generate(
          MasterData.dashboardAndProjectMonthColumnsNames.length,
          (cellIndex) => '0'));

  List<List<String>> dashboardAndProjectAddRowExpenseMonthValue = List.generate(
      6,
          (rowIndex) => List.generate(
          MasterData.dashboardAndProjectMonthColumnsNames.length,
              (cellIndex) => '0'));


  void calculateSum(
      String value, int rowLength, int columnLength, String textField) {
    if (textField == Labels.monthBreakdownTextField) {
      for (int rowIndex = 0; rowIndex < rowLength; rowIndex++) {
        double sum = 0;
        for (int colIndex = 0; colIndex < columnLength; colIndex++) {
          sum += double.tryParse(controller1[rowIndex][colIndex].text) ?? 0;
        }
        dashboardAndProjectMonthTotalFYValue[rowIndex] = sum;
      }
    }
    if (textField == Labels.expenseMonthTextField) {
      for (int rowIndex = 0; rowIndex < rowLength; rowIndex++) {
        double sum = 0;
        for (int colIndex = 0; colIndex < columnLength; colIndex++) {
          sum += double.tryParse(controller2[rowIndex][colIndex].text) ?? 0;
        }
        dashboardAndProjectExpenseTotalFYValue[rowIndex] = sum;
      }
    }
    if (textField == Labels.resourceMonthTextField) {
      for (int rowIndex = 0; rowIndex < rowLength; rowIndex++) {
        double sum = 0;
        for (int colIndex = 0; colIndex < columnLength; colIndex++) {
          sum += double.tryParse(controller3[rowIndex][colIndex].text) ?? 0;
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

  // String selectDropDownOption = StringConstant.dropDownInitialValue[0];
  int dropdownIndex = 0;
  final List<bool> isDropdownIndexOpen =
      List.filled(MasterData.dashboardAndProjectExpenseList.length, false);
  // Selecting option from the Dropdown
  void selectOption(String option, int index) {
    Labels.dropDownInitialValue[index] = option;
    isDropdownIndexOpen[dropdownIndex] = false;
    notifyListeners();
  }

  // Showing Dropdown According to the position
  // Showing Dropdown According to the position
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
    notifyListeners();
  }

  // Searching the data in the Dropdown
  int filterListIterator = 0;

  List<String> getFilteredOptions() {
    filterListIterator++;
    return MasterData.dashboardAndProjectDropdownOptions.where((option) {
      return option.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
  }

  // Adding the row in the List in Other expenses data table.
  void addRow(BuildContext context) {
    var mQ = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final bool isAndroid = DeviceOS.isAndroid;
    final bool isMonitor = DeviceScreen.isMonitor(context);
    final bool isLaptop = DeviceScreen.isLargeScreen(context);
    int rowIndex = 1;
    DataRow newTotalRow = DataRow(
      cells: List.generate(
          MasterData.dashboardAndProjectTotalColumnTitles.length, (colIndex) {
        rowIndex++;
        if (colIndex == 0) {
          return DataCell(SizedBox(
              width: mQ.width / 10,
              child: CustomDropdown(
                index: rowIndex,
              )));
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
              width: mQ.width / 11.5,
              margin: EdgeInsets.all(Insets.s4),
              padding: EdgeInsets.only(
                  left: Insets.s2,
                  right: Insets.s12,
                  top: Insets.s18,
                  bottom: Insets.s4),
              decoration: BoxDecoration(
                  color: kLightGreyShade,
                  border: Border.all(width: 1, color: kGrey),
                  borderRadius: BorderRadius.circular(5)),
              child: (colIndex == 1)
                  ? Text(dashboardAndProjectExpenseTotalFYValue[rowIndex]
                      .toString())
                  : Text(dashboardAndProjectExpenseTotalYTDValue[rowIndex])));
        }
      }),
    );
    int increasingIndex = dashboardAndProjectExpenseMonthDataRows.length;
    increasingIndex = increasingIndex+4;
    DataRow newMonthRow = DataRow(
      cells: List.generate(
          MasterData.dashboardAndProjectMonthColumnsNames.length, (colIndex) {
        return DataCell(
          Container(
              height: mQ.height / 3.5,
              width: mQ.width / 11.5,
              margin: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                  color: kLightGreyShade,
                  border: Border.all(
                      color: isValidAddRowExpenseCost[
                      rowIndex][colIndex]
                          ? kRed
                          : kGrey,
                      width: (isValidAddRowExpenseCost[
                      rowIndex]
                      [colIndex])
                          ? 1.5
                          : 1),
                  borderRadius:
                  BorderRadius.circular(5)),
              child: CustomTextFormField(
                rowIndex: rowIndex,
                cellIndex: colIndex,
                textFormFieldName: Labels.addRowExpenseMonthTextField,
                rowLength: increasingIndex,
                colLength:
                    MasterData.dashboardAndProjectMonthColumnsNames.length,
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
