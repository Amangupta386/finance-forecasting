import 'package:ddofinance/services/base_service.dart';
import 'package:ddofinance/services/urls.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';


///Adding New Project.
class AddNewProjectDataPostRepo extends BaseService {
  String? authToken;

  Future<void> AddNewProjectDataPost(
      int FK_FinancialYear_ID,
      int FK_WTT_Project_ID,
      String forecast,
      String actual,
      String projectStatus) async {

    try {
      Future<String?> getTokenFromLocalStorage() async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        authToken = prefs.getString('authToken')!;
        return authToken;
      }
      authToken = await getTokenFromLocalStorage();
      Map<String, dynamic> requestBody = {
        'FK_FinancialYear_ID': FK_FinancialYear_ID,
        'FK_WTT_Project_ID': FK_WTT_Project_ID,
        'forecast': forecast,
        'actual': actual,
        'projectStatus': projectStatus
      };

      Response response = await makeRequest(
          url: EndPoints.projectCost,
          body: requestBody,
          method: HttpMethod.post,
          authToken: authToken);
      if (response.statusCode == 201) {
        Fluttertoast.showToast(
          msg: "New Record Created successfully",
          toastLength: Toast.LENGTH_SHORT,
          webBgColor: 'Color.fromRGBO(0, 50, 144, 1)', // Set the background color to pink
          fontSize: 16.0,
        );
      }

      else {
        throw 'HTTP Error: ${response.statusCode}';
      }
    } catch (error) {

      throw 'Error during Adding New Project on Add New Project Screen: $error';
    }
  }

}