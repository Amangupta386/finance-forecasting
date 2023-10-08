import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ddofinance/models/projects/project.dart';
import 'package:ddofinance/repository/local_storage.dart';
import 'package:ddofinance/utils/constants/material_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A provider class for managing projects data.
class ProjectsProvider extends ChangeNotifier {
  ///Controller for search box.
  late TextEditingController searchController;

  int _projectIndex = 0;
  bool _toMove = false;

  Future<void> toMoveBuilder() async {
    var prefs = await SharedPreferences.getInstance();
    _projectIndex = prefs.getInt('projectIndex')!;
    _toMove = prefs.getBool('toMove')!;
    notifyListeners();
  }


  setToMove(bool newValue) async{
       _toMove = newValue;
       var prefs = await SharedPreferences.getInstance();
       prefs.setBool('toMove', newValue);
  }

  bool get toMove => _toMove;

  setProjectIndex(int index) async{
    _projectIndex = index;
    var prefs = await SharedPreferences.getInstance();
    prefs.setInt('projectIndex', index);
  }

  int get projectIndex => _projectIndex;

  List<String> addingDataFromEditScreen = [];

  /// List of projects data after applying filtering.
  List<ProjectsModel> filteredSearchBoxData = [];

  ///Future List of projects table data
  late Future<List<ProjectsModel>> dataFromLocalStorageFuture;

  /// List of projects data retrieved from local storage.
  late List<ProjectsModel> dataFromLocalStorage;

  ///Instance of the repository
  final localStorageRepository = ProjectsLocalStorageRepository();

  ///Changing client name and project name from edit screen to projects screen.
  Future<void> changeTableDataFromEditScreen(index) async {
    await (filteredSearchBoxData[index].clientName =
        addingDataFromEditScreen[0]);
    await (filteredSearchBoxData[index].projectName =
        addingDataFromEditScreen[1]);
    addingDataFromEditScreen.clear();
    notifyListeners();
  }

  ///Fetch Resources Data from LocalStorage
  Future<List<ProjectsModel>> getProjectsData() async {
    dataFromLocalStorage = await localStorageRepository.resources();
    filteredSearchBoxData = dataFromLocalStorage;
    return dataFromLocalStorage;
  }

  ///Loads the local storage data
  void loadProjectsData() {
    var futureData = getProjectsData();
    dataFromLocalStorageFuture = futureData;
    notifyListeners();
  }

  ///Method for filtering data table data based on the search term
  void searchBoxFilteredData() {
    String searchTerm = searchController.text.toLowerCase();
    filteredSearchBoxData = dataFromLocalStorage
        .where((element) =>
            element.clientName.toString().toLowerCase().contains(searchTerm) ||
            element.projectName.toString().toLowerCase().contains(searchTerm))
        .toList();

    notifyListeners();
  }

  ///Method to render the text and icon depending upon the status.
  Row buildStatusRow(int index, BuildContext context) {
    final status = filteredSearchBoxData[index].status;
    ThemeData theme = Theme.of(context);
    MediaQueryData mQ = MediaQuery.of(context);
    double deviceWidth = mQ.size.width;
    final ColorScheme colorTheme = theme.colorScheme;
    /// Define default icon and text styles.
    Icon icon;
    TextStyle textStyle;
    if (status.trim() != 'Completed'.trim()) {
      icon = Icon(
        MaterialIcons.progress,
        color: colorTheme.outline,
      );
      textStyle =
          theme.textTheme.bodyMedium!.copyWith(color: colorTheme.outline);
    } else {
      icon = Icon(
        MaterialIcons.completed,
        color: colorTheme.surface,
      );
      textStyle =
          theme.textTheme.bodyMedium!.copyWith(color: colorTheme.surface);
    }

    return Row(
      children: [
        icon,
        SizedBox(
          width: deviceWidth / 250,
        ),
        Text(
          status,
          style: textStyle,
        ),
      ],
    );
  }

  ///Method to navigate to edit projects screen with the required data.
  void navigateToEditProjectScreen(BuildContext context, int index) {
    var selectedProjectId = filteredSearchBoxData[index].id;
    _setProjectIdToLocalStorage(selectedProjectId);
    context.goNamed('editProjectScreen');
  }


 ///setting projects record id to local storage.
  Future<void> _setProjectIdToLocalStorage(int selectedProjectId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('selectedProjectId', selectedProjectId);
  }

  String changeIconDirection = '';
  bool sortAscending = true;
  String sortColumn = '';


  ///This method is sorting column based on the particular column name.
  void sortData(String columnName) {
    changeIconDirection = columnName;
    notifyListeners();
    if (sortColumn == columnName) {
      sortAscending = !sortAscending;
      notifyListeners();
    } else {
      sortColumn = columnName;
      sortAscending = true;
      notifyListeners();
    }

    /// Sort the data based on the selected column
    switch (sortColumn) {
      case 'Client Name':
        filteredSearchBoxData.sort((a, b) {
          return sortAscending
              ? a.clientName.compareTo(b.clientName)
              : b.clientName.compareTo(a.clientName);
        });
        break;
      case 'Project Forecast':
        filteredSearchBoxData.sort((a, b) {
          return sortAscending
              ? a.projectForecast.compareTo(b.projectForecast)
              : b.projectForecast.compareTo(a.projectForecast);
        });
        break;
      case 'Actual Cost':
        filteredSearchBoxData.sort((a, b) {
          return sortAscending
              ? a.actualCost.compareTo(b.actualCost)
              : b.actualCost.compareTo(a.actualCost);
        });
        break;
      case 'Status':
        filteredSearchBoxData.sort((a, b) {
          return sortAscending
              ? a.status.compareTo(b.status)
              : b.status.compareTo(a.status);
        });
        break;
      default:
        break;
    }
    notifyListeners();
  }
}
