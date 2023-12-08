import 'package:ddofinance/models/projects/project.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ddofinance/services/base_service.dart';
import 'package:ddofinance/services/urls.dart';

class ProjectRepository extends BaseService {
  Future<List<ProjectModel>> addProjectRepository() async {
    String? authToken;
    try {
      Future<String?> getTokenFromLocalStorage() async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        authToken = prefs.getString('authToken')!;
        return authToken;
      }

      authToken = await getTokenFromLocalStorage();
      List<dynamic> response = await makeRequest(
        url: EndPoints.projectCost,
        method: HttpMethod.get,
        authToken: authToken,
      );

      if (response.isNotEmpty) {
        List<ProjectModel> projects =
            response.map((data) => ProjectModel.fromJson(data)).toList();
        return projects;
      } else {
        throw 'HTTP Error: $response';
      }
    } catch (error) {
      throw 'Error on Project Screen: $error';
    }
  }
}
