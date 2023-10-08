import 'package:ddofinance/providers/dashboard/dashboard_provider.dart';
import 'package:ddofinance/theme/color_constants.dart';
import 'package:ddofinance/utils/constants/images.dart';
import 'package:ddofinance/utils/device_screens/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class ScrollingIcons extends StatelessWidget {
  final bool isLeftButtonActive;
  final bool isRightButtonActive;
  final VoidCallback scrollToLeftFunction;
  final VoidCallback scrollToRightFunction;
  const ScrollingIcons(
      {Key? key,
      required this.isLeftButtonActive,
      required this.isRightButtonActive,
      required this.scrollToLeftFunction,
      required this.scrollToRightFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mQ = MediaQuery.of(context).size;
    DashboardProvider provider = Provider.of<DashboardProvider>(context, listen: false);
    final bool isAndroid = DeviceOS.isAndroid;
    final bool isMonitor = DeviceScreen.isMonitor(context);
    final bool isLaptop = DeviceScreen.isLargeScreen(context);
    final bool isTablet = DeviceScreen.isTablet(context);
    return Row(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: isLeftButtonActive ? scrollToLeftFunction : null,
          child: CircleAvatar(
            backgroundColor: (isLeftButtonActive) ? kViolet : kGrey,
            radius: 16,
            child:
            SvgPicture.asset(Images.leftArrowIcon),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        GestureDetector(
          onTap:
              isRightButtonActive ? scrollToRightFunction : null,
          child: CircleAvatar(
            backgroundColor: (isRightButtonActive) ? kViolet : kGrey,
            radius: 16,
            child: SvgPicture.asset(Images.rightArrowIcon),
          ),
        ),
      ],
    );
  }
}
