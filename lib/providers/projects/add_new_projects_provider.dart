import 'package:ddofinance/models/dropdown.dart';
import 'package:flutter/material.dart';
import 'package:ddofinance/models/projects/add_new_project.dart';
import 'package:ddofinance/repository/project/add_new_project.dart';

import '../../repository/project/add_new_project_post.dart';
import '../../utils/constants/labels.dart';

class AddProjectProvider extends ChangeNotifier {
  List<AddNewProject> projectsDD = [];

  bool clearTextFormFields = false;

  void isClearTextFormFields(bool toggle) {
    clearTextFormFields = toggle;
    notifyListeners();
  }

  // late List<AddNewProject> countryDDvalues;


  ///Retrieving Projects name dropdown data from Api call
  Future<void> addingAddNewProjectsData() async {
    projectsDD = await AddProjectRepository().addProjectRepository();
    notifyListeners();
  }


  String clientNameInitialValue = '';
  String country = '';
  String currency = '';
  String paymentTerm = '';
  String businessUnit = '';
  late String FK_WTT_Project_ID;
  late String FK_FinancialYear_ID;
  String projectForecast = '';
  String actualCost = '';
  getAddNewProjectDataById(
      String id,
      ) {
    isClearTextFormFields(true);
    FK_WTT_Project_ID = id;
    // print('object  ${FK_WTT_Project_ID}');
    var clientName = projectsDD.firstWhere((element) => element.id == id);
    clientNameInitialValue = clientName.customerName!;
    country = clientName.locationCountry!;
    currency = clientName.currencySymbol!;
    paymentTerm = clientName.paymentTerm!;
    businessUnit = clientName.buName!;
    notifyListeners();
    // print('$clientNameInitialValue   kdjfkdhgkjf');
  }

  ///it is radio group value used in radio button function
  String rGValue = Labels.inProgress;

  ///This method is used to make radio type button
  ///
  // late String statusValue;
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
            Radio<String>(
                value: titles[i],
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

  postData(context) async {
    try {
   var addNewData=   await AddNewProjectDataPostRepo().AddNewProjectDataPost(
          int.parse(FK_FinancialYear_ID),
          int.parse(FK_WTT_Project_ID),
          projectForecast,
          actualCost,
          rGValue);


    } catch (e) {}
  }

  // String abc = '';
  // updateUserFields(String id) {
  //   dropDownValueId=id;
  //   print('object  $dropDownValueId');
  //  var  clientName = projectsDD.firstWhere((element) =>
  //   element.id == id);
  //  abc= clientName.customerName!;
  //  notifyListeners();
  // }
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
}
