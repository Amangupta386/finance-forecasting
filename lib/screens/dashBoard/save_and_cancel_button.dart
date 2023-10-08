import 'package:ddofinance/providers/dashboard/dashboard_provider.dart';
import 'package:ddofinance/services/local_storage_service.dart';
import 'package:ddofinance/utils/constants/labels.dart';
import 'package:ddofinance/utils/device_screens/device_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SaveAndCancel extends StatelessWidget {
  const SaveAndCancel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mQ = MediaQuery.of(context).size;
    var provider = Provider.of<DashboardProvider>(context, listen: false);
    final bool isAndroid = DeviceOS.isAndroid;
    final bool isMonitor = DeviceScreen.isMonitor(context);
    final bool isLaptop = DeviceScreen.isLargeScreen(context);
    final bool isTablet = DeviceScreen.isTablet(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          style: ButtonStyle(
              padding:
                  MaterialStateProperty.all(EdgeInsets.all(mQ.width / 80))),
          onPressed: () {
            CellLocalStorage.saveDataLocalStorage(true, context);
          },
          child: Text(
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
          onPressed: () {},
          child: Text(
            Labels.cancel,
          ),
        ),
      ],
    );
  }
}
