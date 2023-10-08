import 'package:ddofinance/routing/app_router.dart';
import 'package:ddofinance/widgets/notifications/top_snack_bar.dart';
import 'package:dio/dio.dart';

class ExceptionHandler {
  bool dioExceptionHandler(DioException error, dynamic stackTrace) {
    switch (error.type) {
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionTimeout:
        TopSnackBar.showTopSnackBar(rootNavigatorKey.currentState!.context, 'Labels.unableToConnect');
        return false;
      case DioExceptionType.badResponse:
      case DioExceptionType.cancel:
        return true;
        break;
      case DioExceptionType.unknown:
        TopSnackBar.showTopSnackBar(rootNavigatorKey.currentState!.context, 'Labels.checkYourConnection');
        return false;
        break;
      default:
        return true;
    }
  }
}
