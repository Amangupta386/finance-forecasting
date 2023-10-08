import 'dart:convert';
import 'package:ddofinance/models/resources/resources_model.dart';
import 'package:ddofinance/utils/master_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ddofinance/data/projects_data.dart';
import 'package:ddofinance/data/resources_cost_data.dart';
import 'package:ddofinance/models/dashboard/dashboard.dart';
import 'package:ddofinance/models/projects/project.dart';
import 'package:ddofinance/models/resources_cost/resources_cost_model.dart';
import 'package:ddofinance/providers/dashboard/dashboard_provider.dart';

class LocalStorageService {
  LocalStorageService();

  /// Saves a list of `ResourcesModel` objects to local storage.
  static Future<void> setDataInLocalStorage() async {
    var data = MasterData().data;
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Convert the list of `ResourcesModel` objects to JSON.
    final jsonData = data.map((item) => item.toJson()).toList();
    final jsonString = json.encode(jsonData);

    // Save the JSON data to local storage.
    await prefs.setString('resourcesData', jsonString);
  }

  /// Retrieves a list of `ResourcesModel` objects from local storage.
  static Future<List<ResourcesModel>> getDataFromLocalStorage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('resourcesData');
    if (jsonString != null) {
      final Iterable<dynamic> decoded = json.decode(jsonString);

      // Convert decoded JSON data back to a list of `ResourcesModel` objects.
      return decoded.map((item) => ResourcesModel.fromJson(item)).toList();
    }
    // Return an empty list if no data is found in local storage.
    return <ResourcesModel>[];
  }

  /// Asynchronous function to load data for the table from local storage.
  Future<List<ResourcesModel>> loadResourcesTableData() async {
    await setDataInLocalStorage();
    var dataFromLocalStorage = await getDataFromLocalStorage();
    return dataFromLocalStorage;
  }
}




///Ayushi's Project screen local srorage class

/// A class for managing local storage operations.
class LocalStorage {

  /// Sets project data in the local storage.
  ///
  /// This function takes the project data, converts it to JSON format,
  /// and stores it in the SharedPreferences.
  ///
  /// * [dashboardAndProjectDataTableChart] - The project data to be stored.
  static Future<void> setDataInLocalStorage() async {
    var data= ProjectsData().data;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonData =  data.map((item) => item.toJson()).toList();
    final jsonString = json.encode(jsonData);
    await prefs.setString('resourcesData', jsonString);
    // print('$jsonData...............this is the data to set');
  }

  /// Retrieves project data from local storage.
  ///
  /// This function retrieves the project data from SharedPreferences,
  /// decodes it from JSON, and returns a list of [ProjectsModel].
  ///
  /// Returns an empty list if no data is found in local storage.
  static Future<List<ProjectsModel>> getDataFromLocalStorage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('resourcesData');
    if (jsonString != null) {
      final Iterable<dynamic> decoded = json.decode(jsonString);
      // print('$decoded...............this is the data to get');
      return decoded
          .map((item) => ProjectsModel.fromJson(item))
          .toList();
    }
    return <ProjectsModel>[];
  }

  /// Asynchronous function to load data for the table from local storage.
  Future<List<ProjectsModel>> loadProjectsTableData() async {
    await setDataInLocalStorage();
    var dataFromLocalStorage = await getDataFromLocalStorage();
    return dataFromLocalStorage;
  }
}

class ResourcesCostLocalStorage {

  ///To set the data in local storage.
  static Future<void> setDataInLocalStorage() async {
    final List<ResourcesCostModel> data = resourcesData;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonData = data.map((item) => item.toJson()).toList();
    final jsonString = json.encode(jsonData);
    await prefs.setString('resourcesData', jsonString);
  }

  ///To load the data from the local storage.
  static Future<List<ResourcesCostModel>> getDataFromLocalStorage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('resourcesData');
    if (jsonString != null) {
      final Iterable<dynamic> decoded = json.decode(jsonString);
      return decoded
          .map((item) => ResourcesCostModel.fromJson(item))
          .toList();
    }
    return <ResourcesCostModel>[];
  }

  ///To set and get the data from the local storage.
  Future<List<ResourcesCostModel>> loadResourcesCostTableData() async {
    await setDataInLocalStorage();
    var dataFromLocalStorage = await getDataFromLocalStorage();
    return dataFromLocalStorage;
  }
}


class CellLocalStorage {
  static Future<void> saveDataLocalStorage(bool newData, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (newData == false && prefs.getString('initialTableData') != null) {
      return;
    }
    final List jsonData;
    String jsonString;
    if (newData) {
      jsonData = Provider.of<DashboardProvider>(context, listen: false)
          .localData
          .map((item) => item.toJson())
          .toList();
    } else {
      jsonData = MasterData.dashboardAndProjectMonthlyTableData.map((item) => item.toJson()).toList();
    }
    jsonString = jsonEncode(jsonData);
    await prefs.setString('initialTableData', jsonString);
    if (newData) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Data saved to local storage.'),
        ),
      );
    }

    // for (int i = 0; i < monthTotalFYControllers.length; i++) {
    //   String key = 'cell_$i';
    //   prefs.setString(key, monthTotalFYControllers[i].text);
    // }
  }

  static Future<dynamic> getDataLocalStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
  //   for (int i = 0; i < monthTotalFYControllers.length; i++) {
  //     String key = 'cell_$i';
  //     String savedValue = prefs.getString(key) ?? '0';
  //     monthTotalFYControllers[i].text = savedValue;
  //   }
    final decodedList;
    final jsonStrings = prefs.getString('initialTableData');
    if (jsonStrings != null) {
      final decoded = jsonDecode(jsonStrings);
      decodedList = decoded.map((item) => DataTableChartModel.fromJson(item)).toList();
      return decodedList;
    }
  }
}




