import 'dart:convert';
import 'package:ddofinance/models/dashboard/month_breakdown.dart';
import 'package:ddofinance/models/dashboard/other_expenses.dart';
import 'package:ddofinance/models/dashboard/resource_cost.dart';
import 'package:ddofinance/providers/dashboard/dashboard_provider.dart';
import 'package:ddofinance/routing/app_router.dart';
import 'package:ddofinance/screens/dashBoard/table_data_encode.dart';
import 'package:ddofinance/utils/constants/labels.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ddofinance/models/resources_cost/resources_cost_model.dart';

///Ayushi's Project screen local srorage class

/// A class for managing local storage operations.
// class LocalStorage {
//
//   /// Sets project data in the local storage.
//   ///
//   /// This function takes the project data, converts it to JSON format,
//   /// and stores it in the SharedPreferences.
//   ///
//   /// * [dashboardAndProjectDataTableChart] - The project data to be stored.
//   static Future<void> setDataInLocalStorage() async {
//     var data= ProjectsData().data;
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     // final jsonData =  data.map((item) => item.toJson()).toList();
//     final jsonString = json.encode(jsonData);
//     await prefs.setString('resourcesData', jsonString);
//     // print('$jsonData...............this is the data to set');
//   }
//
//   /// Retrieves project data from local storage.
//   ///
//   /// This function retrieves the project data from SharedPreferences,
//   /// decodes it from JSON, and returns a list of [ProjectsModel].
//   ///
//   /// Returns an empty list if no data is found in local storage.
//   static Future<List<ProjectsModel>> getDataFromLocalStorage() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     final jsonString = prefs.getString('resourcesData');
//     if (jsonString != null) {
//       final Iterable<dynamic> decoded = json.decode(jsonString);
//       // print('$decoded...............this is the data to get');
//       return decoded
//           .map((item) => ProjectsModel.fromJson(item))
//           .toList();
//     }
//     return <ProjectsModel>[];
//   }

/// Asynchronous function to load data for the table from local storage.
//   Future<List<ProjectsModel>> loadProjectsTableData() async {
//     await setDataInLocalStorage();
//     var dataFromLocalStorage = await getDataFromLocalStorage();
//     return dataFromLocalStorage;
//   }
// }

class ResourcesCostLocalStorage {
  ///To set the data in local storage.
  static Future<void> setDataInLocalStorage(
      List<ResourcesCostModel> resourcesCost) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonData = resourcesCost.map((item) => item.toJson()).toList();
    final jsonString = json.encode(jsonData);
    await prefs.setString('resourcesData', jsonString);
  }

  ///To load the data from the local storage.
  static Future<List<ResourcesCostModel>> getDataFromLocalStorage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('resourcesData');
    if (jsonString != null) {
      final Iterable<dynamic> decoded = json.decode(jsonString);
      return decoded.map((item) => ResourcesCostModel.fromJson(item)).toList();
    }
    return <ResourcesCostModel>[];
  }

  ///To set and get the data from the local storage.
  // Future<List<ResourcesCostModel>> loadResourcesCostTableData() async {
  //   await setDataInLocalStorage();
  //   var dataFromLocalStorage = await getDataFromLocalStorage();
  //   return dataFromLocalStorage;
  // }
}

var provider = Provider.of<DashboardProvider>(
    rootNavigatorKey.currentState!.context,
    listen: false);

class DashboardProjectLocalStorage {
  static Future<void> saveControllerValuesToLocalStorage(
      BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final text = provider
        .monthBreakdownCommentTextController[provider.commentRowIndex]
            [provider.commentColumnIndex]
        .text;
    await prefs.setString(
        'controller_value${provider.commentRowIndex} ${provider.commentColumnIndex}',
        text);
  }

  static Future<void> loadControllerValuesFromLocalStorage(
      BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString(
            'controller_value${provider.commentRowIndex} ${provider.commentColumnIndex}') !=
        null) {
      final key =
          'controller_value${provider.commentRowIndex} ${provider.commentColumnIndex}';
      final text =
          prefs.getString(key) ?? '0'; // Default to '0' if no value is found
      provider
          .monthBreakdownCommentTextController[provider.commentRowIndex]
              [provider.commentColumnIndex]
          .text = text;
    }
  }

  // Save data to local storage
  static Future<void> saveMonthBreakdownData(
      List<MonthBreakdownModel> data) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonData = data.map((model) => model.toJson()).toList();
    final jsonString = jsonEncode(jsonData);
    await prefs.setString(
        Labels.monthBreakdownKey, DataTableEncode.encodeToBase64(jsonString));
  }

  static Future<void> saveOtherExpenseData(List<OtherExpenseModel> data) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonData = data.map((model) => model.toJson()).toList();
    final jsonString = jsonEncode(jsonData);
    await prefs.setString(
        Labels.otherExpenseKey, DataTableEncode.encodeToBase64(jsonString));
  }

  static Future<void> saveResourceCostData(List<ResourceCostModel> data) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonData = data.map((model) => model.toJson()).toList();
    final jsonString = jsonEncode(jsonData);
    await prefs.setString(
        Labels.resourceCostKey, DataTableEncode.encodeToBase64(jsonString));
  }

  // Retrieve data from local storage
  static Future<List<MonthBreakdownModel>> getMonthBreakdownData() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString(Labels.monthBreakdownKey) != null) {
      var jsonString = prefs.getString(Labels.monthBreakdownKey);
      jsonString = DataTableEncode.decodeFromBase64(jsonString!);
      final jsonData = jsonDecode(jsonString) as List<dynamic>;
      return jsonData.map((item) {
        return MonthBreakdownModel.fromJson(item);
      }).toList();
    } else {
      return [];
    }
  }

  static Future<List<OtherExpenseModel>> getOtherExpenseData() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString(Labels.otherExpenseKey) != null) {
      var jsonString = prefs.getString(Labels.otherExpenseKey);
      jsonString = DataTableEncode.decodeFromBase64(jsonString!);
      final jsonData = jsonDecode(jsonString) as List<dynamic>;
      return jsonData.map((item) {
        return OtherExpenseModel.fromJson(item);
      }).toList();
    } else {
      return [];
    }
  }

  static Future<List<ResourceCostModel>> getResourceCostData() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString(Labels.resourceCostKey) != null) {
      var jsonString = prefs.getString(Labels.resourceCostKey);
      jsonString = DataTableEncode.decodeFromBase64(jsonString!);
      final jsonData = jsonDecode(jsonString) as List<dynamic>;
      return jsonData.map((item) {
        return ResourceCostModel.fromJson(item);
      }).toList();
    } else {
      return [];
    }
  }
}
