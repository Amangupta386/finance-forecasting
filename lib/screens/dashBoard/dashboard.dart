import 'dart:core';
import 'package:ddofinance/providers/dashboard/dashboard_provider.dart';
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
    listviewScrollController = ScrollController();
    listviewScrollController.addListener(() {
      DashboardProvider provider = Provider.of<DashboardProvider>(context, listen: false);
      if (listviewScrollController.position.pixels >= 200.0) {
        provider.isDropdownIndexOpen[provider.dropdownIndex] = false;
        provider.closeCommentBox();
        provider.notifyListeners();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(double.maxFinite.toInt());
    var provider = Provider.of<DashboardProvider>(context);
    var mQ = MediaQuery.of(context).size;
    var deviceHeight = mQ.height;
    var deviceWidth = mQ.width;
    return Scaffold(
      appBar: const CustomAppBar(),
      body: GestureDetector(
        onTap: provider.closeCommentBox,
        child: SizedBox(
          height: deviceHeight,
          width: deviceWidth,
          child: Stack(children: [
            ListView.builder(
              itemCount :MasterData.dashboardAndProjectDataTableChart.length,
              controller: listviewScrollController,
              itemBuilder: (context, index){
                  return MasterData.dashboardAndProjectDataTableChart[index];
              },),
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