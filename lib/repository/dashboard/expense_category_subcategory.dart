import 'package:ddofinance/models/dashboard/dropdown.dart';
import 'package:ddofinance/services/urls.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ddofinance/services/base_service.dart';


class ExpenseCategoryAndSubCategoryRepository extends BaseService {
  Future<List<ExpenseCategoryAndSubCategory>> getExpenseCategorySubcategory() async {
    String? authToken;
    try {
      Future<String?> getTokenFromLocalStorage() async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        authToken = prefs.getString('authToken')!;
        return authToken;
      }

      authToken = await getTokenFromLocalStorage();
      List<dynamic> response = await makeRequest(
        url: EndPoints.getExpenseCategorySubcategory,
        method: HttpMethod.get,
        authToken: authToken,
      );


      if (response.isNotEmpty) {
        List<ExpenseCategoryAndSubCategory> categorySubcategoryData =
            response.map((data) => ExpenseCategoryAndSubCategory.fromJson(data)).toList();
        return categorySubcategoryData;
      } else {
        throw 'HTTP Error: $response';
      }
    } catch (error) {
      throw 'Error occurred: $error';
    }
  }

  Future<Map<String,dynamic>?> postExpenseCategorySubcategory(
      String name,
      int? parentId,
      int createdById,
      int updatedById,
  ) async {
    String? authToken;
    try {
      Future<String?> getTokenFromLocalStorage() async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        authToken = prefs.getString('authToken')!;
        return authToken;
      }
      authToken = await getTokenFromLocalStorage();
      Map<String, dynamic> requestBody = {
        'name': name,
        'parentId': parentId,
        'createdById': createdById,
        'updatedById': updatedById,
      };

      Response response = await makeRequest(
          url: EndPoints.postExpenseCategorySubcategory,
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
        return response.data;
      }

      else {
        throw 'HTTP Error: ${response.statusCode}';
      }
    } catch (error) {

      throw 'Error during Adding New Project on Add New Project Screen: $error';
    }
  }


}
