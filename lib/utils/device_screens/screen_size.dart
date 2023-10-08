import 'package:ddofinance/routing/app_router.dart';
import 'package:ddofinance/utils/device_screens/device_info.dart';
import 'package:flutter/material.dart';

class ScreenSize {
  static double getIconSize({largeIconSize, mediumIconSize, smallIconSize}) {
    final context = rootNavigatorKey.currentState!.context;
    final isLargeScreen = DeviceScreen.isLargeScreen(context);
    final isMediumScreen = DeviceScreen.isTablet(context);
    return (isLargeScreen)
        ? largeIconSize
        : (isMediumScreen)
            ? mediumIconSize
            : smallIconSize;
  }

  static double getFontSize({largeFontSize, mediumFontSize, smallFontSize}) {
    final context = rootNavigatorKey.currentState!.context;
    final isLargeScreen = DeviceScreen.isLargeScreen(context);
    final isMediumScreen = DeviceScreen.isTablet(context);
    return (isLargeScreen)
        ? largeFontSize
        : (isMediumScreen)
            ? mediumFontSize
            : smallFontSize;
  }

  static Widget getSizedBox(
      {double? largeHeight,
      double? mediumHeight,
      double? smallHeight,
      double? largeWidth,
      double? mediumWidth,
      double? smallWidth}) {
    final context = rootNavigatorKey.currentState!.context;
    final isLargeScreen = DeviceScreen.isLargeScreen(context);
    final isMediumScreen = DeviceScreen.isTablet(context);
    return SizedBox(
        width: isLargeScreen
            ? largeWidth
            : isMediumScreen
                ? mediumWidth
                : smallWidth ?? mediumWidth,
        height: isLargeScreen
            ? largeHeight
            : isMediumScreen
                ? mediumHeight
                : smallHeight ?? mediumHeight);
  }

  static double getImageSize(
      {required largeImageSize,
      required mediumImageSize,
      double? smallImageSize}) {
    final context = rootNavigatorKey.currentState!.context;
    final isLargeScreen = DeviceScreen.isLargeScreen(context);
    final isMediumScreen = DeviceScreen.isTablet(context);
    return (isLargeScreen)
        ? largeImageSize
        : (isMediumScreen)
            ? mediumImageSize
            : smallImageSize ?? mediumImageSize;
  }
}
