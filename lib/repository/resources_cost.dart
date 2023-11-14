import 'package:ddofinance/services/urls.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ddofinance/services/base_service.dart';

import '../models/resources_cost/resources_cost_model.dart';

class ResourcesCostRepository extends BaseService {
  Future<List<ResourcesCostModel>> resourcesCostRepository() async {
    String? authToken;
    try {
      Future<String?> getTokenFromLocalStorage() async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        authToken = prefs.getString('authToken')!;
        return authToken;
      }

      authToken = await getTokenFromLocalStorage();
      List<dynamic> response = await makeRequest(
        url: EndPoints.resourcesCost,
        method: HttpMethod.get,
        authToken: authToken,
      );

      if ( response.isNotEmpty ) {
        List<ResourcesCostModel> resources = response
            .map((data) => ResourcesCostModel.fromJson(data))
            .toList();
        return resources;

      } else {
        throw 'HTTP Error: $response';
      }
    } catch (error) {
      throw 'Error occurred: $error';
    }
  }

  Future<List<ResourcesCostModel>> postResourcesCost(List<ChangedData> resultList) async {
    String? authToken;
    try {
      // Map<String, dynamic>? sendData = {'result': resultList.map((data) => data.toJson()).toList()};

      Future<String?> getTokenFromLocalStorage() async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        authToken = prefs.getString('authToken')!;
        return authToken;
      }

      authToken = await getTokenFromLocalStorage();
     var response = await makeRequest(
        url: EndPoints.postResourcesCost,
        method: HttpMethod.post,
        body: resultList,
        authToken: authToken,
      );

      return [];
    } catch (error) {
      throw 'Error occurred: $error';
    }
  }

}