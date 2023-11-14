import 'package:ddofinance/models/projects/project.dart';
import 'package:ddofinance/providers/projects/projects_provider.dart';
import 'package:ddofinance/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ddofinance/utils/constants/labels.dart';
import 'package:ddofinance/repository/project/edit_project_dropdown_repo.dart';


class EditProjectProvider extends ChangeNotifier {
  var projectsProvider = Provider.of<ProjectsProvider>(
      rootNavigatorKey.currentState!.context,
      listen: false);
  late int _selectedProjectId;
  String projectForecast = '';
  String actualCost = '';

  ///it is radio group value used in radio button function
  String rGValue = Labels.inProgress;

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

  updateData(context, ProjectModel selectedProject) async {
    try {
      EditProjectRepository().editProjectData(
          selectedProject.id,
          selectedProject.fkFinancialYearId,
          selectedProject.fkWttProjectId.toString(),
          projectForecast,
          actualCost,
          rGValue);
      Fluttertoast.showToast(
        msg: "Record updated successfully",
        toastLength: Toast.LENGTH_SHORT,
        webBgColor: 'Color.fromRGBO(0, 50, 144, 1)', // Set the background color to pink
        fontSize: 16.0,
      );
      Future.delayed(const Duration(seconds: 1),()=> {
        Provider.of<ProjectsProvider>(context, listen: false).afterViewBuild1(),
        GoRouter.of(context).pop()
      });

    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  ///This method is filtering record based on the id and returning it.
  Future<ProjectModel> findProjectById() async {
    await getSelectedProjectId();
    var selectedProject = projectsProvider.filteredSearchBoxData
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
