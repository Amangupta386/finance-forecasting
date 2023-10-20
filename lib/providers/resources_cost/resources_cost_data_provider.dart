import 'package:flutter/foundation.dart';
import 'package:ddofinance/models/resources_cost/resources_cost_model.dart';
import 'package:ddofinance/repository/local_storage.dart';
import 'package:ddofinance/utils/validators.dart';

///A provider class used for resource cost details.
class ResourcesCostDataProvider extends ChangeNotifier {
  List<ResourcesCostModel> _dataFromLocal = [];
  List<List<bool>> _isSelected = [];
  List<List<bool>> _isValid =[];
  List<ResourcesCostModel> _filteredList = [];
  bool _isToggle = true;
  late int validColIdx;
  late int validRowIdx;

  final localStorageRepository = ResourcesCostLocalStorageRepository();

  late Future<List<ResourcesCostModel>> dataFromLocalStorageFuture;

  List<ResourcesCostModel> get data => _dataFromLocal;

  List<List<bool>> get isSelectedList => _isSelected;

  List<List<bool>> get isValidList => _isValid;

  List<ResourcesCostModel> get filtered => _filteredList;

  bool get boolValue => _isToggle;

  ///To filter the data from the data table.
  void filterData(String searchTerm) {
    _filteredList = _dataFromLocal.where((element) =>
    element.eName.toString().toLowerCase().contains(searchTerm) ||
        element.eId.toString().toLowerCase().contains(searchTerm) ||
        element.designation.toString().toLowerCase().contains(searchTerm))
        .toList();
    notifyListeners();
  }

  ///To sort the id of the employee.
  void sortEmployeeId() {
    _filteredList.sort((a, b) => a.eId.compareTo(b.eId));

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
      for (int i=0; i<elements.length ; i++) {
        if(elements[i]){
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
      notifyListeners();
    } else {
      _isValid[rowIndex][colIndex] = false;
      notifyListeners();
    }
  }

  ///To load data from the local storage and initialize the some data accordingly.
  Future<List<ResourcesCostModel>> getResourcesCostData() async {
    _dataFromLocal = await localStorageRepository.resources();

    _isSelected = List.generate(
               _dataFromLocal.length, (_) => List.filled(_dataFromLocal.length, false));

    _isValid = List.generate(
               _dataFromLocal.length, (_) => List.filled(_dataFromLocal.length, false));

    _filteredList = _dataFromLocal;
    notifyListeners();
    return _dataFromLocal;
  }

  void loadResourceCostData() {
    var futureData = getResourcesCostData();
    dataFromLocalStorageFuture = futureData;
    notifyListeners();
  }

  ///To update the current cell value with the new value that the user enters.
  void updateDataCellValue(int rowIndex, int colIndex, String newValue){
    switch(colIndex){
      case 0:
        filtered[rowIndex].cost1 = newValue;
        notifyListeners();
        break;
      case 1:
        filtered[rowIndex].cost2 = newValue;
        notifyListeners();
        break;
      case 2:
        filtered[rowIndex].cost3 = newValue;
        notifyListeners();
        break;
      case 3:
        filtered[rowIndex].cost4 = newValue;
        notifyListeners();
        break;
    }
  }

  ///To display the data of the cells according to the indexes.
  String showData(int rowIndex, int colIndex){
    switch(colIndex){
      case 0:
        return filtered[rowIndex].cost1;
      case 1:
        return filtered[rowIndex].cost2;
      case 2:
        return filtered[rowIndex].cost3;
      case 3:
        return filtered[rowIndex].cost4;
    }
    return 'hy';
  }
}