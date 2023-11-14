import 'package:ddofinance/data/resources_cost_data.dart';
import 'package:ddofinance/utils/common_methods.dart';
import 'package:ddofinance/utils/constants/labels.dart';
import 'package:flutter/foundation.dart';
import 'package:ddofinance/models/resources_cost/resources_cost_model.dart';
import 'package:ddofinance/utils/validators.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../repository/resources_cost.dart';

///A provider class used for resource cost details.
class ResourcesCostDataProvider extends ChangeNotifier {
  List<List<bool>> _isSelected = [];
  List<List<bool>> _isValid = [];
  List<ResourcesCostModel> _filteredList = [];
  bool _isToggle = true;
  late int validColIdx;
  late int validRowIdx;
  List<ResourcesCostModel> resourcesCost = [];
  List<ChangedData> changedDataList = [];
  int? userId;

  late Future<List<ResourcesCostModel>> dataFromLocalStorageFuture;

  List<ResourcesCostModel> get data => resourcesCost;

  List<List<bool>> get isSelectedList => _isSelected;

  List<List<bool>> get isValidList => _isValid;

  List<ResourcesCostModel> get filtered => _filteredList;

  bool get boolValue => _isToggle;

  bool _hasEmptyOrInvalidFields = false;

  bool get hasEmptyOrInvalidFields => _hasEmptyOrInvalidFields;

  ///To filter the data from the data table.
  void filterData(String searchTerm) {
    _filteredList = resourcesCost
        .where((element) =>
            element.employeeName
                .toString()
                .toLowerCase()
                .contains(searchTerm) ||
            element.employeeCode
                .toString()
                .toLowerCase()
                .contains(searchTerm) ||
            element.designationName
                .toString()
                .toLowerCase()
                .contains(searchTerm))
        .toList();
    notifyListeners();
  }

  ///To sort the id of the employee.
  void sortEmployeeId() {
    _filteredList.sort((a, b) => a.employeeCode.compareTo(b.employeeCode));

    if (_isToggle) {
      _filteredList = _filteredList.reversed.toList();
    }
    _isToggle = !_isToggle;
    notifyListeners();
  }

  ///To toggle the color of the container.
  void toggleList(rowIndex, colIndex) {
    tapHandler();
    _isSelected[rowIndex][colIndex] = !_isSelected[rowIndex][colIndex];
    notifyListeners();
  }

  ///To handle the tap event in the data table.
  void tapHandler() {
    for (var elements in _isSelected) {
      for (int i = 0; i < elements.length; i++) {
        if (elements[i]) {
          elements[i] = false;
        }
      }
    }
    notifyListeners();
  }

  ///To show the validation of the text field.
  void showValidation(String value, int rowIndex, int colIndex) {
    if (TextFieldValidation.validateInput(value) == '!') {
      _isValid[rowIndex][colIndex] = true;
      validColIdx = colIndex;
      validRowIdx = rowIndex;
      _hasEmptyOrInvalidFields = true;
      notifyListeners();
    } else {
      _isValid[rowIndex][colIndex] = false;
      _hasEmptyOrInvalidFields = false;
      notifyListeners();
    }
  }

  ///To load data from the local storage and initialize the some data accordingly.
  Future<List<ResourcesCostModel>> getResourcesCostData() async {
    resourcesCost = await ResourcesCostRepository().resourcesCostRepository();
    _filteredList = resourcesCost;

    _isSelected = List.generate(resourcesCost.length,
        (_) => List.filled(tableLabels.length - 4, false));

    _isValid = List.generate(resourcesCost.length,
        (_) => List.filled(tableLabels.length - 4, false));

    notifyListeners();
    return resourcesCost;
  }

  void loadResourceCostData() {
    dataFromLocalStorageFuture = getResourcesCostData();
    notifyListeners();
  }

  ///To update the current cell value with the new value that the user enters.
  void updateDataCellValue(String id, int colIndex, String newValue) async {
    ResourcesCostModel resources =
        resourcesCost.firstWhere((element) => element.employeeCode == id);
    userId ??= await CommonMethods.getIdFromLocalStorage();
    switch (colIndex) {
      case 0:
        resources.monthlyCostComp1 = newValue;
        notifyListeners();
        break;
      case 1:
        resources.monthlyCostComp2 = newValue;
        notifyListeners();
        break;
      case 2:
        resources.monthlyCostComp3 = newValue;
        notifyListeners();
        break;
      case 3:
        resources.monthlyCostComp4 = newValue;
        notifyListeners();
        break;
    }

    ChangedData changedData = ChangedData(
        id: (resources.id == "N/A") ? "N/A" : int.parse(resources.id),
        FK_WTT_Employee_ID: int.parse(resources.FK_WTT_Employee_ID),
        monthlyCostComp1: resources.monthlyCostComp1,
        monthlyCostComp2: resources.monthlyCostComp2,
        monthlyCostComp3: resources.monthlyCostComp3,
        monthlyCostComp4: resources.monthlyCostComp4,
        createdById: userId);

    if (!changedDataList.contains(changedData)) {
      changedDataList.add(changedData);
    }
  }

  ///To display the data of the cells according to the indexes.
  String showData(String id, int colIndex) {
    ResourcesCostModel resources =
        resourcesCost.firstWhere((element) => element.employeeCode == id);
    switch (colIndex) {
      case 0:
        return resources.monthlyCostComp1;
      case 1:
        return resources.monthlyCostComp2;
      case 2:
        return resources.monthlyCostComp3;
      case 3:
        return resources.monthlyCostComp4;
    }
    return '';
  }

  void onSave() {
    if (_hasEmptyOrInvalidFields) {
      Fluttertoast.showToast(
          msg: Labels.warningMessage,
          webBgColor: 'Color.fromRGBO(0, 50, 144, 1)',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          fontSize: 16.0);
      return; // Prevent saving when there are empty or invalid fields.
    }

    tapHandler();
    Map<int, ChangedData> resultMap = {};

    for (var item in changedDataList) {
      resultMap[item.FK_WTT_Employee_ID] = item;
    }

    List<ChangedData> resultList = resultMap.values.toList();

    ResourcesCostRepository().postResourcesCost(resultList);

    Fluttertoast.showToast(
        msg: "Data saved successfully.",
        webBgColor: 'Color.fromRGBO(0, 50, 144, 1)',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        fontSize: 16.0);
  }
}
