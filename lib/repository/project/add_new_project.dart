import 'package:shared_preferences/shared_preferences.dart';
import 'package:ddofinance/models/projects/add_new_project.dart';
import 'package:ddofinance/services/base_service.dart';
import 'package:ddofinance/services/urls.dart';

///Get Project
class AddProjectRepository extends BaseService {
  Future<List<AddNewProject>> addProjectRepository() async {
    String? authToken;
    try {
      Future<String?> getTokenFromLocalStorage() async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        authToken = prefs.getString('authToken')!;
        return authToken;
      }

      authToken = await getTokenFromLocalStorage();
      List<dynamic> response = await makeRequest(
        url: EndPoints.project,
        method: HttpMethod.get,
        authToken: authToken,
      );
      if (response.isNotEmpty) {
        List<AddNewProject> projects =
            response.map((data) => AddNewProject.fromJson(data)).toList();
        return projects;
      } else {
        throw 'HTTP Error: $response';
      }
    } catch (error) {
      throw 'Error during getting project details on Add Project Screen: $error';
    }
  }
}
