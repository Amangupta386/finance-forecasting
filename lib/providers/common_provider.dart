//
// import 'package:ddofinance/models/authentication/login.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class CommonProvider with ChangeNotifier {
//
//   late LoginModel _loginResponse;
//   // var loginStream = StreamController.broadcast();
//
//
//   dispose(){
//     // loginStream.close();
//     super.dispose();
//   }
//
//   set setUserDetails(LoginModel loginResponse) => _loginResponse = loginResponse;
//
//   int get userId => _loginResponse.ofUserId;
//
//
//   Future<bool> setLoginUserDetails(LoginResponse userDetails) async {
//     try {
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       if (userDetails == null) {
//         prefs.setString(Constants.USER_DETAILS_KEY, null);
//       }
//
//       prefs.setString(
//         Constants.USER_DETAILS_KEY,
//         jsonEncode(userDetails.toJson()),
//       );
//       setUserDetails = userDetails;
//       return true;
//     } catch (e) {
//       return true;
//     }
//   }
//
//
//   Future<LoginResponse> getLoginCredentails() async {
//     LoginResponse userDetails;
//     try {
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       String stringValue = prefs.getString(Constants.USER_DETAILS_KEY);
//       if (stringValue != null) {
//         userDetails = LoginResponse.fromJson(jsonDecode(stringValue));
//       }
//       var commonProvider = Provider.of<CommonProvider>(navigatorKey.currentContext, listen: false);
//       commonProvider.setUserDetails = userDetails;
//       loginStream.add(userDetails);
//
//       return userDetails;
//     } catch (e) {
//       loginStream.add(userDetails);
//       return userDetails;
//     }
//   }
// }