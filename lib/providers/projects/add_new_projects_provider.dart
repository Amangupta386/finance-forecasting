import 'package:flutter/material.dart';

class AddProjectProvider extends ChangeNotifier{
  // List jsonValues = [];
  // List<String> addSelectedValues = [];
  // Map<String, String> myMap = {};
  List<String> dropdownItems1 = ['2023-24', '2022-23', '2021-22', '2020-21'];
  List<String> dropdownItems2 = [
    'Australia',
    'France',
    'United States Of America',
    'United Kingdom'
  ];
  List<String> dropdownItems3 = ['\$US', '\$AU', 'INR'];
  List<String> dropdownItems4 = ['1 Month', '2 Month', '3 Month', '1 Year'];
  List<String> dropdownItems5 = [
    'Akshay Shrivastava',
    'Atul Shrivastava',
    'Prashant Kumar',
    'Sandeep Gupta'
  ];

// void convertListToMap() {
//   List<String> keys = [
//     'financialYear',
//     'clientName',
//     'projectName',
//     'country',
//     'currency',
//     'paymentTeam',
//     'BU',
//   ];
//
//   myMap = Map.fromIterables(keys, addSelectedValues);
//   jsonValues.add(myMap);
//   print('$jsonValues  jsonValuessss');
// }
//
// void saveData(context) async {
//   try {
//     String jsonString = json.encode(jsonValues);
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setString('selectedItems', jsonString);
//     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//       content: Text('Selected items saved to local storage.'),
//     ));
//
//     convertListToMap();
//     print(addSelectedValues);
//   } catch (e) {
//     print('something went wrong');
//   }
// }
}