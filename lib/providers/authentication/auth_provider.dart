import 'package:ddofinance/models/authentication/login.dart';
import 'package:ddofinance/providers/navigation_rail_provider.dart';
import 'package:ddofinance/repository/authentication.dart';
import 'package:ddofinance/routing/app_router.dart';
import 'package:ddofinance/routing/app_routes.dart';
import 'package:ddofinance/services/base_service.dart';
import 'package:ddofinance/services/exception_handler.dart';
import 'package:ddofinance/services/urls.dart';
import 'package:ddofinance/utils/common_methods.dart';
import 'package:ddofinance/utils/constants/labels.dart';
import 'package:ddofinance/utils/models.dart';
import 'package:ddofinance/widgets/notifications/top_snack_bar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

/// A provider class for authentication and user details.
class AuthProvider extends ChangeNotifier {
  var loginControllers = LoginControllers();
  final authenticationRepository = AuthenticationRepository();

  bool _auth = false;
  bool _toggle = true;

  NavigationRailProvider navigationRailProvider =
      Provider.of<NavigationRailProvider>(
          rootNavigatorKey.currentState!.context,
          listen: false);

  @override
  dispose() {
    loginControllers.email.dispose();
    loginControllers.password.dispose();
    super.dispose();
  }

  bool get auth {
    return _auth;
  }

  set auth(bool auth) {
    _auth = auth;
    notifyListeners();
  }

  bool get toggle {
    return _toggle;
  }

  set toggle(bool toggle) {
    _toggle = toggle;
    notifyListeners();
  }

  // void authenticate() {
  //   if (loginControllers.email.text == 'user@walkingtree.tech' &&
  //       loginControllers.password.text == '12345') {
  //     auth = true;
  //     notifyListeners();
  //   } else {
  //     auth = false;
  //     notifyListeners();
  //   }
  // }

  void onLogOut() {
    // Display a top snackbar with a message.
    TopSnackBar.showTopSnackBar(rootNavigatorKey.currentState!.context,
        'You have been logged out Successfully');

    // Perform a logout action by setting the authentication status to false.
    auth = false;
    navigationRailProvider.resetSelectedPreference();
    //Clear the Text Fields.
    loginControllers.email.clear();
    loginControllers.password.clear();

    // Navigate back to the home page.
    GoRouter.of(rootNavigatorKey.currentState!.context).go('/');
  }

  /// Toggle is used for toggling the eye icon when user what switch on the visibility of password.
  void onToggle() {
    _toggle = !_toggle;
    notifyListeners();
  }

  ///onSaved is used to check the current state of login form so it before authenticate it can check validation.
  // void onSaved(formKey) {
  //   if (formKey.currentState!.validate()) {
  //     formKey.currentState!.save();
  //     // authenticate();
  //     if (auth == true) {
  //       rootNavigatorKey.currentState!.context.go('/dashboard');
  //     } else {
  //       TopSnackBar.showTopSnackBar(rootNavigatorKey.currentState!.context,
  //           Labels.wrongCredentialsMessage);
  //     }
  //   }
  // }

  Future<void> onCLickLogin(GlobalKey<FormState> formKey) async {
    String username = loginControllers.email.text;
    String password = loginControllers.password.text;
    try {
      if (formKey.currentState!.validate()) {
        CommonMethods.setLoaderStatus(true);
        LoginModel response = await authenticationRepository
            .loginAuthentication(username, password);
        // CommonMethods.setLoaderStatus(false);
        if (response != null && response is LoginModel) {
          // CommonMethods.setLoginUserDetails(response);
          rootNavigatorKey.currentState!.context.go(Routes.dashBoardScreen);
        } else {
          TopSnackBar.showTopSnackBar(
              rootNavigatorKey.currentState!.context, 'Invalid Credentials');
        }
      }
    } on DioException catch (error, stackTrace) {
      CommonMethods.setLoaderStatus(false);
      if (error.response != null && error.response!.statusCode == 403) {
        Fluttertoast.showToast(
            msg: error.response!.data['message'] ?? 'Invalid Credentials');
      } else if (ExceptionHandler().dioExceptionHandler(error, stackTrace)) {
        TopSnackBar.showTopSnackBar(rootNavigatorKey.currentState!.context,
            'Labels.unableToConnect'); //unable to connect to server
      } else {
        TopSnackBar.showTopSnackBar(rootNavigatorKey.currentState!.context,
            'Labels.unableToConnect'); //unable to connect to server
      }
    } on Exception catch (e, stashTrace) {
      CommonMethods.setLoaderStatus(false);
      TopSnackBar.showTopSnackBar(rootNavigatorKey.currentState!.context,
          'Labels.checkYourConnection'); //check your Internet connection
    }
  }
}
