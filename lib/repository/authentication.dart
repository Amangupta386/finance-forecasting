import 'package:ddofinance/models/authentication/login.dart';
import 'package:ddofinance/routing/app_router.dart';
import 'package:ddofinance/services/base_service.dart';
import 'package:ddofinance/services/urls.dart';
import 'package:ddofinance/utils/constants/labels.dart';
import 'package:ddofinance/widgets/notifications/top_snack_bar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationRepository extends BaseService {
  Future<LoginModel> loginAuthentication(
      String username, String password) async {
    Response response;
    Future<String?> authToken = getTokenFromLocalStorage();
    dio.options.headers["Authorization"] = "Bearer $authToken";
    try {
      Map<String, dynamic> requestBody = {
        'username': username,
        'password': password,
      };
      response = await makeRequest(
          url: EndPoints.loginUrl, body: requestBody, method: HttpMethod.post);

      if (response.statusCode == 200 && response.data != null) {
        String authToken = LoginModel.fromJson(response.data).token;
        int id = LoginModel.fromJson(response.data).id;
        saveTokenToLocalStorage(authToken, id);
        return LoginModel.fromJson(response.data);
      } else if (response.statusCode == 401) {
        throw DioException(
            type: DioExceptionType.connectionError,
            requestOptions: RequestOptions());
      } else {
        throw 'HTTP Error: ${response.statusMessage}';
      }
    } catch (error) {
      showErrorSnackBar();
      throw 'Error during authentication: $error';
    }
  }

  void showErrorSnackBar() {
    if (rootNavigatorKey.currentState!.mounted) {
      ColorScheme? themeColor =
          Theme.of(rootNavigatorKey.currentState!.context).colorScheme;
      TopSnackBar.showTopSnackBar(
          rootNavigatorKey.currentState!.context,
          Labels.wrongCredentialsMessage,
          themeColor.error,
          themeColor.tertiary,
          themeColor.tertiary);
    }
  }

  Future<void> saveTokenToLocalStorage(String token, int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('authToken', token);
    await prefs.setInt('userId', id);
  }

  Future<String?> getTokenFromLocalStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('authToken');
  }
}
