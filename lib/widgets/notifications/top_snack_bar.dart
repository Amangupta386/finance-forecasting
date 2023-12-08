import 'package:ddofinance/utils/device_screens/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:ddofinance/utils/constants/material_icons.dart';
import 'package:ddofinance/utils/device_screens/device_info.dart';

/// `TopSnackBar` is a custom utility class for displaying a snack bar at the top of the screen with customizable appearance and behavior.
class TopSnackBar {
  /// Displays a top snack bar with the specified [message].
  ///
  /// - [context]: The BuildContext of the widget that is calling this method.
  /// - [message]: The message to display in the snack bar.
  static void showTopSnackBar(BuildContext context, String message,Color bgColor,Color textColor,Color iconColor) {
    // Obtain the theme and screen size information from the current context.
    final mQ = MediaQuery.of(context).size;
    final deviceHeight = mQ.height;
    final deviceWidth = mQ.width;

    // Check the size of the current window to determine the screen type.
    final isLargeScreen = DeviceScreen.isLargeScreen(context);
    final isMediumScreen = DeviceScreen.isTablet(context);

    // Create a SnackBar widget with custom appearance and behavior.
    final snackBar = SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            MaterialIcons.error,
            // Through this it also the size of icon is going to render according to screen type.
            size: ScreenSize.getIconSize(
              largeIconSize: deviceWidth / 90,
              mediumIconSize: deviceWidth / 50,
              smallIconSize: deviceWidth / 30,
            ),
            color: iconColor,
          ),
          ScreenSize.getSizedBox(
              largeWidth: deviceWidth / 160, mediumWidth: deviceWidth / 200),
          Expanded(
            flex: 1,
            child: Text(message,
                style: TextStyle(
                  color: textColor,
                  // Through this it also the size of text is going to render according to screen type.
                  fontSize: ScreenSize.getFontSize(
                    largeFontSize: mQ.width / 130,
                    mediumFontSize: mQ.width / 70,
                    smallFontSize: mQ.width / 45,
                  ),
                )),
          ),
        ],
      ),
      duration: const Duration(seconds: 2),
      backgroundColor: bgColor,
      showCloseIcon: true,
      closeIconColor: iconColor,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(
        top: 1,
        bottom: (isLargeScreen)
            ? deviceHeight - 50
            : (isMediumScreen)
                ? deviceHeight - 46
                : deviceHeight - 46,
        left: (isLargeScreen)
            ? deviceWidth / 2.5
            : (isMediumScreen)
                ? deviceWidth / 3.5
                : deviceWidth / 3.5,
        right: (isLargeScreen)
            ? deviceWidth / 2.5
            : (isMediumScreen)
                ? deviceWidth / 3.5
                : deviceWidth / 4.5,
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
