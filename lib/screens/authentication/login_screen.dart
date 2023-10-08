import 'package:ddofinance/utils/constants/images.dart';
import 'package:flutter/material.dart';
import 'package:ddofinance/utils/device_screens/device_info.dart';
import 'package:ddofinance/screens/authentication/login_form.dart';
import 'package:ddofinance/widgets/image_asset.dart';
import 'package:ddofinance/widgets/positioned_all.dart';

/// A widget representing the login screen.
class LoginScreen extends StatelessWidget {
  final VoidCallback onSign;

  /// Constructs a [LoginScreen] with a callback function [onSign].
  const LoginScreen({Key? key, required this.onSign}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Authentication.authentication();
    // Get the screen size and theme from the current context.
    final mQ = MediaQuery.of(context).size;
    final deviceHeight = mQ.height;
    final deviceWidth = mQ.width;
    final theme = Theme.of(context);
    return Scaffold(
      body: Container(
        color: theme.colorScheme.surfaceVariant,
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            // Position background images using customize PositionedAll widget
            PositionedAll(
                top: deviceHeight / 4.5,
                left: deviceWidth / 7.8,
                child: ImageAsset(
                  imageName: Images.photoAlbum1Image,
                  width: deviceWidth / 16,
                )),
            PositionedAll(
                top: deviceHeight / 2.8,
                left: deviceWidth / 4.8,
                child: ImageAsset(
                  imageName: Images.photoAlbum2Image,
                  width: deviceWidth / 22,
                )),
            PositionedAll(
                bottom: 0,
                left: deviceWidth / 5.5,
                child: ImageAsset(
                  imageName: Images.manOnChairImage,
                  width: deviceWidth / 6,
                )),
            PositionedAll(
                bottom: 0,
                left: deviceWidth / 1.4,
                child: ImageAsset(
                  imageName: Images.tableVaseImage,
                  width: deviceWidth / 6,
                )),

            _buildResponsiveForm(context, deviceHeight, deviceWidth),
          ],
        ),
      ),
    );
  }

  /// Build the responsive login form based on screen size.
  Widget _buildResponsiveForm(BuildContext context, deviceHeight, deviceWidth) {
    final Widget responsiveForm;
    // Determine the screen size and adjust the form's position accordingly.
    if (DeviceScreen.isLargeScreen(context)) {
      responsiveForm = PositionedAll(
        top: deviceHeight / 5,
        left: deviceWidth / 2.5,
        child: LoginForm(
          onSigned: onSign,
        ),
      );
    } else if (DeviceScreen.isTablet(context)) {
      responsiveForm = PositionedAll(
        top: deviceHeight / 5,
        left: deviceWidth / 3.5,
        right: deviceWidth / 3.5,
        child: LoginForm(
          onSigned: onSign,
        ),
      );
    } else {
      responsiveForm = PositionedAll(
        top: deviceHeight / 5,
        left: deviceWidth / 3.5,
        right: deviceWidth / 5.5,
        child: LoginForm(
          onSigned: onSign,
        ),
      );
    }
    return responsiveForm;
  }
}
