import 'package:ddofinance/services/urls.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ddofinance/services/base_service.dart';

//////put request
class EditProjectRepository extends BaseService {
  Future<void> editProjectData(
      int id,
      int FK_FinancialYear_ID,
      String FK_WTT_Project_ID,
      String forecast,
      String actual,
      String projectStatus) async {

    String? authToken;
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
          url: '${EndPoints.projectCost}/$id',
          body: requestBody,
          method: HttpMethod.put,
          authToken: authToken);


      if (response.statusCode == 200) {

      } else {
        throw 'HTTP Error: ${response.statusCode}';
      }
    } catch (error) {
      throw 'Error during Updating Data on Edit Project Screen: $error';
    }
  }
}
