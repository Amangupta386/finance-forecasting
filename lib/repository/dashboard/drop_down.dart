import 'package:ddofinance/models/dropdown.dart';
import 'package:ddofinance/services/urls.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ddofinance/services/base_service.dart';

class DropDownRepository extends BaseService {
  Future<Map<String, List<DropDownModel>>> dropDownRepository() async {
    String? authToken;
    try {
      Future<String?> getTokenFromLocalStorage() async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        authToken = prefs.getString('authToken')!;
        return authToken;
      }

      authToken = await getTokenFromLocalStorage();
      List<dynamic> fyResponse = await makeRequest(
        url: EndPoints.financialYear,
        method: HttpMethod.get,
        authToken: authToken,
      );

      List<dynamic> buResponse = await makeRequest(
        url: EndPoints.businessUnit,
        method: HttpMethod.get,
        authToken: authToken,
      );

      List<dynamic> clientResponse = await makeRequest(
        url: EndPoints.client,
        method: HttpMethod.get,
        authToken: authToken,
      );

      List<dynamic> projectResponse = await makeRequest(
        url: EndPoints.project,
        method: HttpMethod.get,
        authToken: authToken,
      );

      if ( fyResponse.isNotEmpty && buResponse.isNotEmpty && clientResponse.isNotEmpty && projectResponse.isNotEmpty) {
        List<DropDownModel> dropDownData1 = fyResponse
            .map((data) => DropDownModel.fromJson(data))
            .toList();

        List<DropDownModel> dropDownData2 = buResponse
            .map((data) => DropDownModel.fromJson(data))
            .toList();

        List<DropDownModel> dropDownData3 = clientResponse
            .map((data) => DropDownModel.fromJson(data))
            .toList();

        List<DropDownModel> dropDownData4 = projectResponse
            .map((data) => DropDownModel.fromJson(data))
            .toList();

        return {
          'result 1': dropDownData1,
          'result 2': dropDownData2,
          'result 3': dropDownData3,
          'result 4': dropDownData4
        };

      } else {
        throw 'HTTP Error: $fyResponse';
      }
    } catch (error) {
      throw 'Error occurred: $error';
    }
  }
}