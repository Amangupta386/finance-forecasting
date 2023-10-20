import 'package:ddofinance/models/resources/resources_model.dart';
import 'package:ddofinance/models/resources_cost/resources_cost_model.dart';
import 'package:ddofinance/services/local_storage_service.dart';

class LocalStorageRepository extends LocalStorageService {
  Future<List<ResourcesModel>> resources() async {
    // LoginResponse loginResponse;
    var response = await loadResourcesTableData();
    if (response != null) {
      //  if(response != null && response['responseData'] != null) {
      //    ToastMessage("${response['message'] ?? ''}");
      //    loginResponse = LoginResponse.fromJson(response['responseData']);
    }
    //return loginResponse;
    return response;
  }
}


// class ProjectsLocalStorageRepository extends LocalStorage {
//   Future<List<ProjectsModel>> resources() async {
//     // LoginResponse loginResponse;
//     var response = await loadProjectsTableData();
//     if (response != null) {
//       //  if(response != null && response['responseData'] != null) {
//       //    ToastMessage("${response['message'] ?? ''}");
//       //    loginResponse = LoginResponse.fromJson(response['responseData']);
//     }
//     //return loginResponse;
//     return response;
//   }
// }

///To load data from the local storage.
class ResourcesCostLocalStorageRepository extends ResourcesCostLocalStorage {
  Future<List<ResourcesCostModel>> resources() async {
    // LoginResponse loginResponse;
    var response = await loadResourcesCostTableData();
    if (response != null) {
      //  if(response != null && response['responseData'] != null) {
      //    ToastMessage("${response['message'] ?? ''}");
      //    loginResponse = LoginResponse.fromJson(response['responseData']);
    }
    //return loginResponse;
    return response;
  }
}

