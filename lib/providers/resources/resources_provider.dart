import 'package:ddofinance/models/resources/resources_model.dart';
import 'package:ddofinance/repository/resources.dart';
import 'package:flutter/material.dart';

class ResourceProvider extends ChangeNotifier {
  bool _toggle = true;
  bool _sortAscending = true;
  String _sortColumn = '';
  String changeIconDirection = '';

  // Variables used for store data and render according to searchController on the textfield.
  late Future<List<ResourcesModel>> _dataFromLocalStorageFuture;
  List<ResourcesModel> dataFromLocalStorage = [];
  List<ResourcesModel> filteredSearchBoxData = [];

  get dataFromLocalStorageFuture {
    return _dataFromLocalStorageFuture;
  }

  set dataFromLocalStorageFuture(data) {
    _dataFromLocalStorageFuture = data;
    notifyListeners();
  }

  bool get sortAscending {
    return _sortAscending;
  }

  set sortAscending(isAscending) {
    _sortAscending = isAscending;
    notifyListeners();
  }

  bool get toggle {
    return _toggle;
  }

  set toggle(isAscending) {
    _toggle = isAscending;
    notifyListeners();
  }

  /// Callback function for filtering data based on search input.
  void searchBoxFilteredData(String searchTerm) {
    filteredSearchBoxData = dataFromLocalStorage
        .where((element) =>
            element.employeeName
                .toString()
                .toLowerCase()
                .contains(searchTerm) ||
            element.clientName.toString().toLowerCase().contains(searchTerm) ||
            element.projectName.toString().toLowerCase().contains(searchTerm))
        .toList();
    notifyListeners();
  }

  ///Fetch Resources Data from LocalStorage
  Future<List<ResourcesModel>> getResourcesData() async {
    dataFromLocalStorage =
        await ResourcesRepository().resourcesDataRepository();
    filteredSearchBoxData = dataFromLocalStorage;
    notifyListeners();
    return dataFromLocalStorage;
  }

  void loadResourcesData() {
    var futureData = getResourcesData();
    dataFromLocalStorageFuture = futureData;
    notifyListeners();
  }

  void sortData(String columnName) {
    changeIconDirection = columnName;
    notifyListeners();
    if (_sortColumn == columnName) {
      // If already sorted by this column, reverse the order
      sortAscending = !sortAscending;
      notifyListeners();
    } else {
      _sortColumn = columnName;
      sortAscending = true;
      notifyListeners();
    }

    // Sort the data based on the selected column
    switch (_sortColumn) {
      case 'Resource Cost':
        filteredSearchBoxData.sort((a, b) {
          return sortAscending
              ? a.resourceCost.compareTo(b.resourceCost)
              : b.resourceCost.compareTo(a.resourceCost);
        });
        break;
      case 'Employee Name':
        filteredSearchBoxData.sort((a, b) {
          return sortAscending
              ? a.employeeName.compareTo(b.employeeName)
              : b.employeeName.compareTo(a.employeeName);
        });
        break;
      default:
        break;
    }
    notifyListeners();
  }
}
