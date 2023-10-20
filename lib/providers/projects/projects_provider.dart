import 'package:ddofinance/repository/project/projects.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ddofinance/models/projects/project.dart';
import 'package:ddofinance/utils/constants/material_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A provider class for managing projects data.
class ProjectsProvider extends ChangeNotifier {
  late TextEditingController searchController;
  int _projectIndex = 0;
  bool _toMove = false;

  Future<void> toMoveBuilder() async {
    var prefs = await SharedPreferences.getInstance();
    _projectIndex = prefs.getInt('projectIndex')!;
    _toMove = prefs.getBool('toMove')!;
    notifyListeners();
  }

  setToMove(bool newValue) async {
    _toMove = newValue;
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool('toMove', newValue);
  }

  bool get toMove => _toMove;

  setProjectIndex(int index) async {
    _projectIndex = index;
    var prefs = await SharedPreferences.getInstance();
    prefs.setInt('projectIndex', index);
  }

  int get projectIndex => _projectIndex;

  List<ProjectModel> filteredSearchBoxData = [];
  late List<ProjectModel> dataFromApiCall;
  late Future<List<ProjectModel>> dataFromApiCallFuture;

  Future<List<ProjectModel>> getProjectsData() async {
    dataFromApiCall = await ProjectRepository().addProjectRepository();
    filteredSearchBoxData = dataFromApiCall;
    return dataFromApiCall;
  }

  void loadProjectsData() {
    var futureData = getProjectsData();
    dataFromApiCallFuture = futureData;
    notifyListeners();
  }

  void searchBoxFilteredData() {
    String searchTerm = searchController.text.toLowerCase();
    filteredSearchBoxData = dataFromApiCall
        .where((element) =>
    element.customerName
        .toString()
        .toLowerCase()
        .contains(searchTerm) ||
        element.projectName.toString().toLowerCase().contains(searchTerm))
        .toList();
    notifyListeners();
  }

  ///Method to render the text and icon depending upon the status.
  Row buildStatusRow(int index, BuildContext context) {
    final status = filteredSearchBoxData[index].projectStatus;
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
          theme.textTheme.bodySmall!.copyWith(color: colorTheme.outline);
    } else {
      icon = Icon(
        MaterialIcons.completed,
        color: colorTheme.surface,
      );
      textStyle =
          theme.textTheme.bodySmall!.copyWith(color: colorTheme.surface);
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
              ? a.customerName.compareTo(b.customerName)
              : b.customerName.compareTo(a.customerName);
        });
        break;
      case 'Project Forecast':
        filteredSearchBoxData.sort((a, b) {
          int aForecast = int.tryParse(a.forecast) ??
              0; // Convert the string to an integer or use 0 if it's not a valid integer.
          int bForecast = int.tryParse(b.forecast) ??
              0; // Convert the string to an integer or use 0 if it's not a valid integer.

          return sortAscending
              ? aForecast.compareTo(bForecast)
              : bForecast.compareTo(aForecast);
        });
        break;

      case 'Actual Cost':
        filteredSearchBoxData.sort((a, b) {
          int actualA = int.parse(a.actual);
          int actualB = int.parse(b.actual);

          return sortAscending
              ? actualA.compareTo(actualB)
              : actualB.compareTo(actualA);
        });
        break;
      case 'Status':
        filteredSearchBoxData.sort((a, b) {
          return sortAscending
              ? a.projectStatus.compareTo(b.projectStatus)
              : b.projectStatus.compareTo(a.projectStatus);
        });
        break;
      default:
        break;
    }
    notifyListeners();
  }
}
