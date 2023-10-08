import 'dart:convert';
import 'package:ddofinance/models/projects/project.dart';
import 'package:ddofinance/providers/projects/projects_provider.dart';
import 'package:ddofinance/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ddofinance/utils/constants/labels.dart';

class EditProjectProvider extends ChangeNotifier {
  var projectsProvider = Provider.of<ProjectsProvider>(
      rootNavigatorKey.currentState!.context,
      listen: false);

   late int _selectedProjectId;

  ///This array is adding the input field values from edit screen
  List<String> addSelectedValues = [];

  ///We have to send the selected data from edit screen i.e why we've created this map and adding all values to it
  Map<String, String> selectedItemsMap = {};
  List jsonValues = [];

  ///it is radio group value used in radio button function
  int rGValue = 0;

  ///data of FY Drop down.
  List<String> financialYearDropDownData = [
    '2023-24',
    '2022-23',
    '2021-22',
    '2020-21'
  ];

  ///data of country Drop down.
  List<String> countryDropDownData = [
    'Australia',
    'France',
    'United States Of America',
    'United Kingdom'
  ];

  ///data of currency Drop down.
  List<String> currencyDropDownData = ['\$US', '\$AU', 'INR'];

  ///data of PT Drop down.
  List<String> paymentTeamDropDownData = [
    '1 Month',
    '2 Month',
    '3 Month',
    '1 Year'
  ];

  ///data of BU Drop down.
  List<String> businessUnitDropDownData = [
    'Akshay Shrivastava',
    'Atul Shrivastava',
    'Prashant Kumar',
    'Sandeep Gupta'
  ];

  ///Initial value of FY Drop down.
  String financialYearInitialValue = '2023-24';

  ///Initial value of country Drop down.
  String countryInitialValue = 'United States Of America';

  ///Initial value of currency Drop down.
  String currencyInitialValue = '\$US';

  ///Initial value of PT Drop down.
  String paymentTeamInitialValue = '3 Month';

  ///Initial value of BU Drop down.
  String buInitialValue = 'Akshay Shrivastava';

  ///This method is making json type structure by taking all the selected values from EditProject Screen.
  convertListToMap() {
    List<String> keys = [
      'financialYear',
      'clientName',
      'projectName',
      'country',
      'currency',
      'paymentTeam',
      'BU',
      'projectForecast',
      'actualCost'
    ];
    print(addSelectedValues);
    selectedItemsMap = Map.fromIterables(keys, addSelectedValues);
    jsonValues.add(selectedItemsMap);
    // print('$jsonValues hvhg');
  }

  ///This method is saving the json type data to Local storage
  void saveData(context) async {
    try {
      await convertListToMap();
      String jsonString = json.encode(jsonValues);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('selectedItems', jsonString);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Selected items saved to local storage.')));
      print(jsonString);
    } catch (e) {
      print(e);
    }
  }

  ///This method is used to make radio type button
  List<Widget> makeRadioListTile(context) {
    List<String> titles = [Labels.inProgress, Labels.completed];
    List<Widget> list = <Widget>[];
    for (int i = 0; i < 2; i++) {
      list.add(
        Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 140,
            ),
            Radio<int>(
                value: i,
                groupValue: rGValue,
                activeColor: Colors.indigo,
                onChanged: (value) {
                  rGValue = value!;
                  notifyListeners();
                }),
            Text(
              titles[i],
              style: Theme.of(context).textTheme.bodyMedium,
            )
          ],
        ),
      );
    }
    return list;
  }

  ///This method is filtering record based on the id and returning it.
  Future<ProjectsModel> findProjectById() async {
    await getSelectedProjectId();
   var  selectedProject = projectsProvider.filteredSearchBoxData
        .firstWhere((project) => _selectedProjectId == project.id);


     return selectedProject;
  }

  ///This method is getting id from local storage.
  Future<void> getSelectedProjectId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int savedProjectId = prefs.getInt('selectedProjectId')!;
    _selectedProjectId = savedProjectId;
    notifyListeners();
  }
}
