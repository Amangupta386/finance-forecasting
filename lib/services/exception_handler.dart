import 'package:ddofinance/utils/constants/labels.dart';
import 'package:dio/dio.dart';

class ExceptionHandler {
  String dioExceptionHandler(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.connectionError:
        return Labels.checkYourConnection;
      case DioExceptionType.badResponse:
        return Labels.wrongCredentialsMessage;
      case DioExceptionType.connectionTimeout:
        return Labels.unableToConnect;
      case DioExceptionType.cancel:
        return Labels.wrongCredentialsMessage;
      case DioExceptionType.receiveTimeout:
        return Labels.unableToConnect;
      case DioExceptionType.unknown:
        return 'Check Credentials or Connectivity';
      default:
        return 'Check Credentials or Connectivity';
    }
  }
}
