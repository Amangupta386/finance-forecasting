import 'package:ddofinance/providers/projects/projects_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ddofinance/models/projects/add_new_project.dart';
import 'package:ddofinance/repository/project/add_new_project.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:ddofinance/repository/project/add_new_project_post.dart';
import 'package:ddofinance/utils/constants/labels.dart';


class AddProjectProvider extends ChangeNotifier {
  List<AddNewProject> projectsDD = [];

  bool clearTextFormFields = false;

  void isClearTextFormFields(bool toggle) {
    clearTextFormFields = toggle;
    notifyListeners();
  }

  List<bool> toggleValidator = [false, false];
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
    var clientName = projectsDD.firstWhere((element) => element.id == id);
    clientNameInitialValue = clientName.customerName!;
    country = clientName.locationCountry!;
    currency = clientName.currencySymbol!;
    paymentTerm = clientName.paymentTerm!;
    businessUnit = clientName.buName!;
    notifyListeners();
  }

  ///it is radio group value used in radio button function
  String rGValue = Labels.inProgress;

  ///This method is used to make radio type button
  ///
  // late String statusValue;
  // List<Widget> makeRadioListTile(context) {
  //   List<String> titles = [Labels.inProgress, Labels.completed];
  //   List<Widget> list = <Widget>[];
  //   for (int i = 0; i < 2; i++) {
  //     list.add(
  //       Row(
  //         children: [
  //           SizedBox(
  //             width: MediaQuery.of(context).size.width / 140,
  //           ),
  //           Radio<String>(
  //               value: titles[i],
  //               groupValue: rGValue,
  //               activeColor: Colors.indigo,
  //               onChanged: (value) {
  //                 rGValue = value!;
  //                 notifyListeners();
  //               }),
  //           Text(
  //             titles[i],
  //             style: Theme.of(context).textTheme.bodyMedium,
  //           )
  //         ],
  //       ),
  //     );
  //   }
  //   return list;
  // }


  String? errorText;

  postData(context) async {
    try {
      await AddNewProjectDataPostRepo().AddNewProjectDataPost(
          int.parse(FK_FinancialYear_ID),
          int.parse(FK_WTT_Project_ID),
          projectForecast,
          actualCost,
          rGValue);
      Provider.of<ProjectsProvider>(context, listen: false).afterViewBuild1();
      GoRouter.of(context).pop();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

}
