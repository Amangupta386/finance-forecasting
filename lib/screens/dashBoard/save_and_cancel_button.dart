import 'package:ddofinance/providers/dashboard/dashboard_provider.dart';
import 'package:ddofinance/services/local_storage_service.dart';
import 'package:ddofinance/utils/constants/labels.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SaveAndCancel extends StatelessWidget {
  final String title;
  const SaveAndCancel({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    var mQ = MediaQuery.of(context).size;
    var provider = Provider.of<DashboardProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          style: ButtonStyle(
              padding:
                  MaterialStateProperty.all(EdgeInsets.all(mQ.width / 80))),
          onPressed: () {
            if(title == Labels.monthByMonthBreakdown){
              DashboardProjectLocalStorage.saveMonthBreakdownData(provider.dashboardAndProjectMonthBreakdownData);
            }
            if(title == Labels.otherExpense){
              DashboardProjectLocalStorage.saveOtherExpenseData(provider.dashboardAndProjectOtherExpenseModelData);
            }
            if(title == Labels.resourceCostHeading){
              DashboardProjectLocalStorage.saveResourceCostData(provider.dashboardAndProjectResourcesCostData);
            }

          },
          child: const Text(
            Labels.save,
          ),
        ),
        SizedBox(
          width: mQ.width / 80,
        ),
        ElevatedButton(
          style: ButtonStyle(
              padding:
                  MaterialStateProperty.all(EdgeInsets.all(mQ.width / 80))),
          onPressed: () {

          },
          child: const Text(
            Labels.cancel,
          ),
        ),
      ],
    );
  }
}