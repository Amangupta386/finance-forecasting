import 'package:shared_preferences/shared_preferences.dart';
import 'package:ddofinance/services/base_service.dart';

import '../models/resources_cost/resources_cost_model.dart';

class ResourcesRepository extends BaseService {
  Future<List<ResourcesCostModel>> resourcesDataRepository() async {
    String? authToken;
    try {
      Future<String?> getTokenFromLocalStorage() async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        authToken = prefs.getString('authToken')!;
        return authToken;
      }

      authToken = await getTokenFromLocalStorage();
      List<dynamic> response = await makeRequest(
        url: '',
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
}