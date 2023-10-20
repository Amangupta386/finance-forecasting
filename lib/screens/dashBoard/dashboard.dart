import 'dart:core';
import 'package:ddofinance/providers/dashboard/dashboard_provider.dart';
import 'package:ddofinance/providers/projects/add_new_projects_provider.dart';
import 'package:ddofinance/providers/projects/projects_provider.dart';
import 'package:ddofinance/screens/dashBoard/dashboard_dropdown.dart';
import 'package:ddofinance/screens/dashBoard/dashboard_project_datatable.dart';
import 'package:ddofinance/screens/dashBoard/other_expense_data_row.dart';
import 'package:ddofinance/utils/constants/labels.dart';
import 'package:ddofinance/utils/master_data.dart';
import 'package:ddofinance/widgets/appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'custom_drop_down.dart';


class DashBoard extends StatefulWidget {
  DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  late final ScrollController listviewScrollController;


  @override
  void dispose() {
    listviewScrollController.dispose(); // Dispose the controller here.
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DashboardProvider provider = Provider.of<DashboardProvider>(context, listen: false);
    provider.addingDropDownValues();
    listviewScrollController = ScrollController();
    listviewScrollController.addListener(() {
      if (listviewScrollController.position.pixels >= 200.0) {
        provider.isDropdownIndexOpen[provider.dropdownIndex] = false;
        provider.closeCommentBox();
        provider.notifyListeners();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<DashboardProvider>(context);
    var mQ = MediaQuery.of(context).size;
    var deviceHeight = mQ.height;
    var deviceWidth = mQ.width;
    ProjectsProvider projectsProvider = Provider.of<ProjectsProvider>(context);
    AddProjectProvider addProjectProvider = Provider.of<AddProjectProvider>(context);
    return Scaffold(
      appBar: const CustomAppBar(),
      body: GestureDetector(
        onTap: provider.closeCommentBox,
        child: SizedBox(
          height: deviceHeight,
          width: deviceWidth,
          child: Stack(children: [
            FutureBuilder(
              future:  projectsProvider.toMoveBuilder(),
              builder: (context, snapshot){
                // if(addProjectProvider.screenLoading) {
                //   return const CircularProgressIndicator();
                //   }
                //   else
                  {
                    return ListView(
                      controller: listviewScrollController,
                      children: [
                        const DashboardDropDown(),
                        DashboardProjectDatatable(
                          headingText: Labels.monthByMonthBreakdown,
                          firstColRowLength: MasterData.dashboardAndProjectMonthRowNames.length,
                        ),
                        DashboardProjectDatatable(
                          headingText: Labels.otherExpense,
                          firstColRowLength: dashboardAndProjectExpenseTotalDataRows.length,
                        ),
                        DashboardProjectDatatable(
                          headingText: Labels.resourceCostHeading,
                          firstColRowLength: MasterData.dashboardAndProjectResourcesCost.length,
                        ),
                      ],
                    );
                }
              },
            ),
            if (provider.isDropdownIndexOpen[provider.dropdownIndex])
              Positioned(
                  top: provider.getDropDownPositionX,
                  left: provider.getDropDownPositionY,
                  child: DropDown(
                    index: provider.dropdownIndex,
                  )),
          ]),
        ),
      ),
    );
  }
}