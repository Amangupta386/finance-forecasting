import 'dart:html';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ddofinance/models/authentication/login.dart';
import 'package:ddofinance/repository/authentication.dart';
import 'package:ddofinance/routing/app_router.dart';
import 'package:ddofinance/routing/app_routes.dart';
import 'package:ddofinance/utils/constants/labels.dart';
import 'package:ddofinance/utils/models.dart';
import 'package:ddofinance/widgets/notifications/top_snack_bar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A provider class for authentication and user details.
class AuthProvider extends ChangeNotifier {
  var loginControllers = LoginControllers();
  final authenticationRepository = AuthenticationRepository();

  bool _auth = false;
  bool _toggle = true;
  bool _isLoading = false;

  @override
  dispose() {
    loginControllers.email.dispose();
    loginControllers.password.dispose();
    super.dispose();
  }

  bool get isLoading {
    return _isLoading;
  }

  set isLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  bool get auth {
    return _auth;
  }

  set auth(bool auth) {
    _auth = auth;
    notifyListeners();
  }

  Future<bool> saveAuthFromLocalStorage(auth) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool('auth', auth);
  }

  Future<void> checkToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _auth = prefs.getBool('auth')!;
  }

  bool get toggle {
    return _toggle;
  }

  set toggle(bool toggle) {
    _toggle = toggle;
    notifyListeners();
  }

  // Retrieve the token when needed
  Future<bool> retrieveTokenAndDoSomething() async {
    String? token = await authenticationRepository.getTokenFromLocalStorage();
    if (token != null) {
      auth = true;
      saveAuthFromLocalStorage(auth);
      return auth;
    } else {
      auth = false;
      saveAuthFromLocalStorage(auth);
      return auth;
    }
  }

  Future<void> resetLoginSharedPreferenceToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  void blockBrowserForwardButton() {
    // Listen for the popstate event, which is fired when the user tries to navigate back.
    window.addEventListener('popstate', (event) {
      // Push a new history entry with the current URL.
      window.history.pushState({}, '', window.location.href);
    });
  }

  void unBlockBrowserForwardButton() {
    // Listen for the popstate event, which is fired when the user tries to navigate back.
    window.removeEventListener('popstate', (event) {
      // Push a new history entry with the current URL.
      window.history.pushState({}, '', window.location.href);
    });
  }

  void deleteRoutingHistory() {
    // Get the number of entries in the browser history.
    int historyLength = window.history.length;

    // Iterate over the browser history entries, starting from the index of the new history entry, and delete them.
    for (int i = historyLength - 1; i > 0; i--) {
      window.history.back();
      window.history.replaceState({}, '', '');
    }
  }

  void onLogOut() {
    ColorScheme theme =
        Theme.of(rootNavigatorKey.currentState!.context).colorScheme;
    // Display a top snackBar with a message.
    TopSnackBar.showTopSnackBar(
        rootNavigatorKey.currentState!.context,
        Labels.logoutCustomMessage,
        theme.onSecondaryContainer,
        theme.secondaryContainer,
        theme.secondaryContainer);

    // Perform a logout action by setting the authentication status to false.
    auth = false;
    isLoading = false;
    resetLoginSharedPreferenceToken();
    //Clear the Text Fields.
    loginControllers.email.clear();
    loginControllers.password.clear();

    // This method is deleting all routing history.
    deleteRoutingHistory();
    blockBrowserForwardButton();

    // Navigate back to the home page.
    AppRouter.router.go('/');
  }

  Future<void> alertBox(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(Labels.sessionExpired),
          content: const Text(Labels.sessionMsg),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                // Redirect to the login screen.
                onLogOut();
              },
              child: const Text(Labels.goToLogin),
            ),
          ],
        );
      },
    );
  }

  /// Toggle is used for toggling the eye icon when user what switch on the visibility of password.
  void onToggle() {
    _toggle = !_toggle;
    notifyListeners();
  }

  ///onCLickLogin is used to check the current state of login form so it before authenticate it can check validation.
  Future<void> onCLickLogin(GlobalKey<FormState> formKey) async {
    ColorScheme theme =
        Theme.of(rootNavigatorKey.currentState!.context).colorScheme;
    String username = loginControllers.email.text;
    String password = loginControllers.password.text;
    try {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();

        bool isConnected = await checkInternetConnection();
        if (isConnected) {
          LoginModel response = await authenticationRepository
              .loginAuthentication(username, password);
          await retrieveTokenAndDoSomething();
          isLoading = true;
          Future.delayed(const Duration(seconds: 2), () {
            if (auth == true && response.token.isNotEmpty) {
              unBlockBrowserForwardButton();
              GoRouter.of(rootNavigatorKey.currentState!.context)
                  .go(Routes.dashBoardScreen);
              isLoading = false;
              loginControllers.email.clear();
              loginControllers.password.clear();
            } else {
              TopSnackBar.showTopSnackBar(
                  rootNavigatorKey.currentState!.context,
                  Labels.wrongCredentialsMessage,
                  theme.error,
                  theme.tertiary,
                  theme.tertiary);
              rootNavigatorKey.currentState!.context.go(Routes.initialScreen);
            }
          });
        } else {
          Fluttertoast.showToast(
            webPosition: "right",
            msg: Labels.checkYourConnection,
            webBgColor: "red",
            textColor: Colors.white,
            gravity: ToastGravity.TOP,
          );
        }
      }
    } on DioException catch (error) {
      if (error.response?.statusCode == 401) {
        TopSnackBar.showTopSnackBar(
            rootNavigatorKey.currentState!.context,
            Labels.wrongCredentialsMessage,
            theme.error,
            theme.tertiary,
            theme.tertiary);
      } else if (error.type == DioExceptionType.connectionError) {
        Fluttertoast.showToast(
            msg: Labels.checkYourConnection); //unable to connect to server
      } else {
        Fluttertoast.showToast(
            msg: Labels.unableToConnect); //unable to connect to server
      }
    }
  }

  Future<bool> checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }
}
