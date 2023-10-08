import 'package:ddofinance/models/authentication/login.dart';
import 'package:ddofinance/routing/app_router.dart';
import 'package:ddofinance/services/base_service.dart';
import 'package:ddofinance/services/urls.dart';
import 'package:ddofinance/widgets/notifications/top_snack_bar.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';



class AuthenticationRepository extends BaseService{

   Future<LoginModel> loginAuthentication(String username,String password)async {

     try{
       Map<String, dynamic> requestBody = {
         'username': username,
         'password': password,
       };
       Response response = await makeRequest(url: Urls.loginUrl,body: requestBody, method: HttpMethod.post);

       if(response.statusCode == 200  && response.data != null ){

         // After successful authentication, save the token
         String authToken = LoginModel.fromJson(response.data).token;
         saveTokenToLocalStorage(authToken);

           return LoginModel.fromJson(response.data);
       } else {
         throw 'HTTP Error: ${response.statusCode}';
       }
     }catch(error){
       TopSnackBar.showTopSnackBar(rootNavigatorKey.currentState!.context, 'You have entered the wrong credentials');
       throw 'Error during authentication: $error';
     }
   }

   Future<void> saveTokenToLocalStorage(String token) async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     await prefs.setString('authToken', token);
   }

   Future<String?> getTokenFromLocalStorage() async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     return prefs.getString('authToken');
   }



// Retrieve the token when needed
  Future<void> retrieveTokenAndDoSomething() async {
    String? token = await getTokenFromLocalStorage();
    if (token != null) {
      // Token retrieved, do something with it
      print('Token: $token');
    } else {
      print('Token not found in local storage.');
    }
  }

}
