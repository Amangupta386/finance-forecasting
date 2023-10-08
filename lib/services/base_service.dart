import 'package:ddofinance/services/urls.dart';
import 'package:dio/dio.dart';
import 'package:ddofinance/utils/constants/constants.dart';

enum HttpMethod {
  get,
  post,
  delete,
  put,
  patch,
  download
  // Add more HTTP methods like put, delete, etc.
}

class BaseService {
  final Dio dio;

  BaseService() : dio = Dio();

  Future<dynamic> makeRequest<T>(
      {required String url,
      String? baseUrl,
      required HttpMethod method,
        Map<String, dynamic>? body,
      Map<String, dynamic>? queryParameters,
      Options? options,
      dynamic savePath,
      String? contentType,
      CancelToken? token}) async {
    dio.options.baseUrl = baseUrl ?? Urls.baseUrl;
    dio.options.connectTimeout = Constants.connectionTimeOut; //5s
    dio.options.receiveTimeout = Constants.receiveTimeOut; //5s
    dio.options.contentType = contentType ?? 'application/json';
    dio.options.headers = {"Connection": "Keep-Alive"};

    Response<dynamic> response;


    switch (method) {
      case HttpMethod.get:
        if (queryParameters != null && queryParameters.isNotEmpty) {
          response = await dio.get(
            url,
            queryParameters: queryParameters,
          );
          return response.data;
        }
        response = await dio.get<T>(
          url,
          cancelToken: token,
        );
        return response.data;
        break;
      case HttpMethod.post:
        response = await dio.post<T>(
          url,
          data: body,
          queryParameters: queryParameters,
          options: options,
        );

        break;
      case HttpMethod.delete:
        response = await dio.delete<T>(
          url,
          data: body,
          queryParameters: queryParameters,
          options: options,
        );
        break;
      case HttpMethod.put:
        response = await dio.put<T>(
          url,
          data: body,
          queryParameters: queryParameters,
          options: options,
        );
        break;
      case HttpMethod.patch:
        response = await dio.patch<T>(
          url,
          data: body,
          queryParameters: queryParameters,
          options: options,
        );
      case HttpMethod.download:
        response = await dio.download(
          url,
          savePath,
          data: body,
          queryParameters: queryParameters,
          options: options,
        );
        break;
      // Add cases for other HTTP methods like PUT, DELETE, etc.
      default:
        throw Exception('You have used another http method instead of CRUD');
    }
    return response;
  }

  void close() {
    dio.close();
  }
}
