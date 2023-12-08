import 'dart:core';
import 'package:ddofinance/providers/dashboard/dashboard_provider.dart';
import 'package:ddofinance/providers/projects/projects_provider.dart';
import 'package:ddofinance/screens/dashBoard/dashboard_dropdown.dart';
import 'package:ddofinance/screens/dashBoard/dashboard_project_datatable.dart';
import 'package:ddofinance/utils/constants/labels.dart';
import 'package:ddofinance/utils/master_data.dart';
import 'package:ddofinance/widgets/appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'custom_drop_down.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

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





    DashboardProvider provider =
        Provider.of<DashboardProvider>(context, listen: false);
    provider.getCategorySubcategoryData();

    provider.navigationSelection(context);
    if (provider.dashboardAndProjectOtherExpenseModelData.isEmpty) {
      Provider.of<DashboardProvider>(context, listen: false).addExpensesRow();
      Provider.of<DashboardProvider>(context, listen: false).addExpensesRow();
    }
    provider.addingDropDownValues();
    listviewScrollController = ScrollController();
    listviewScrollController.addListener(() {
      if (listviewScrollController.position.pixels >= 200.0) {
        provider
            .dashboardAndProjectOtherExpenseModelData[provider
                .dashboardAndProjectOtherExpenseModelData[
                    provider.dropdownIndex]
                .customDropDown
                .index]
            .isDropdownIndexOpen = false;
        provider.closeCommentBox();
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var mQ = MediaQuery.of(context).size;
    var deviceHeight = mQ.height;
    var deviceWidth = mQ.width;
    DashboardProvider provider = Provider.of<DashboardProvider>(context);
    return Scaffold(
      appBar: const CustomAppBar(),
      body: GestureDetector(
        onTap: provider.closeCommentBox,
        child: SizedBox(
          height: deviceHeight,
          width: deviceWidth,
          child: Stack(children: [
            Consumer<ProjectsProvider>(
              builder: (context, myData, child) {
                return FutureBuilder(
                  future: myData.toMoveBuilder(context),
                  builder: (context, snapshot) {
                    return ListView(
                      controller: listviewScrollController,
                      children: [
                        const DashboardDropDown(),
                        DashboardProjectDatatable(
                          headingText: Labels.monthByMonthBreakdown,
                          rowsLength: MasterData
                              .dashboardAndProjectMonthRowNames.length,
                        ),
                        const DashboardProjectDatatable(
                          headingText: Labels.otherExpense,
                          rowsLength: 2,
                        ),
                        const DashboardProjectDatatable(
                          headingText: Labels.resourceCostHeading,
                          rowsLength: 3,
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            if (provider
                .dashboardAndProjectOtherExpenseModelData[
                    provider.dropdownIndex]
                .isDropdownIndexOpen)
              Positioned(
                  top: provider.getDropDownPositionX,
                  left: provider.getDropDownPositionY,
                  child: DropDown(
                    rowData: provider.dashboardAndProjectOtherExpenseModelData[
                        provider.dropdownIndex],
                  )),
          ]),
        ),
      ),
    );
  }
}
