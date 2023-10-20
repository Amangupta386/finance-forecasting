import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ddofinance/models/authentication/login.dart';
import 'package:ddofinance/repository/authentication.dart';
import 'package:ddofinance/routing/app_router.dart';
import 'package:ddofinance/routing/app_routes.dart';
import 'package:ddofinance/utils/common_methods.dart';
import 'package:ddofinance/utils/constants/labels.dart';
import 'package:ddofinance/utils/models.dart';
import 'package:ddofinance/widgets/notifications/top_snack_bar.dart';
import 'package:dio/dio.dart';
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

  bool get isLoading{
    return _isLoading;
  }

  set isLoading(bool loading){
    _isLoading = loading;
        notifyListeners();
  }

  bool get auth{
    return _auth;
  }
  set auth(bool auth){
    _auth = auth;
   notifyListeners();
  }

  // Future<void> get getAuthFromLocalStorage async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //  bool isAuthenticated = prefs.getBool('auth') ;
  //   print('${isAuthenticated} this is the bool value');
  //  notifyListeners();
  // }

  Future<bool> saveAuthFromLocalStorage(auth)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool('auth', auth);
  }


  Future<void> checkToken()async{
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
      return auth ;
    } else {
      auth = false;
       saveAuthFromLocalStorage(auth);
       return auth;
    }
  }

  Future<void> resetLoginSharedPreferenceToken()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  void handleLogout() {
    // Pop all routes except the login route
    while ( GoRouter.of(rootNavigatorKey.currentState!.context).canPop()) {
      GoRouter.of(rootNavigatorKey.currentState!.context).dispose();
    }
    AppRouter.router.replace(Routes.initialScreen);
  }

  void onLogOut() {
    // Display a top snackBar with a message.
    TopSnackBar.showTopSnackBar(rootNavigatorKey.currentState!.context,
        'You have been logged out Successfully');
    // getInitialRoute();
    // Perform a logout action by setting the authentication status to false.
    auth = false;
    isLoading = false;

    resetLoginSharedPreferenceToken();
    //Clear the Text Fields.
    loginControllers.email.clear();
    loginControllers.password.clear();

    // Navigate back to the home page.
    handleLogout();
    // GoRouter.of(rootNavigatorKey.currentState!.context).go(Routes.initialScreen);
    // AppRouter.
  }

  /// Toggle is used for toggling the eye icon when user what switch on the visibility of password.
  void onToggle() {
    _toggle = !_toggle;
    notifyListeners();
  }

  ///onCLickLogin is used to check the current state of login form so it before authenticate it can check validation.
  Future<void> onCLickLogin(GlobalKey<FormState> formKey) async {
    String username = loginControllers.email.text;
    String password = loginControllers.password.text;
    try {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();

        bool isConnected = await checkInternetConnection();
        if(isConnected){
          LoginModel response = await authenticationRepository.loginAuthentication(username, password);
          await retrieveTokenAndDoSomething();
          isLoading = true;
          Future.delayed(const Duration(seconds: 2),(){
            if (auth == true && response.token.isNotEmpty ) {
              // CommonMethods.setLoginUserDetails(response);
              rootNavigatorKey.currentState!.context.go(Routes.dashBoardScreen);
            }
            else {
              TopSnackBar.showTopSnackBar(rootNavigatorKey.currentState!.context,
                  'You have entered wrong credentials');
              rootNavigatorKey.currentState!.context.go(Routes.initialScreen);
            }
          });
        }else{
          Fluttertoast.showToast(
            webPosition: "center",
            msg: Labels.checkYourConnection,
            webBgColor:"green",
            textColor: Colors.white,
            gravity: ToastGravity.TOP,
          );
        }
      }
    }on DioException catch (error) {
      if (error.response?.statusCode == 401) {
        TopSnackBar.showTopSnackBar(rootNavigatorKey.currentState!.context,
            'You have entered wrong credentials');
      } else if (error.type == DioExceptionType.connectionError ) {
        Fluttertoast.showToast( msg: Labels.checkYourConnection); //unable to connect to server
      } else {
        Fluttertoast.showToast( msg: 'Labels.unableToConnect'); //unable to connect to server
      }
    } on Exception catch (e) {
      CommonMethods.setLoaderStatus(false);
      TopSnackBar.showTopSnackBar(rootNavigatorKey.currentState!.context,'Labels.checkYourConnection'); //check your Internet connection
    }
  }

  Future<bool> checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }
}
