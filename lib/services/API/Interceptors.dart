import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:emp_app/helpers/db/db_helpers.dart';

class AppInterceptors extends Interceptor {
  /// Base Config For Dio
  Dio createDio() {
    return Dio(BaseOptions(
        connectTimeout: 15000,
        receiveTimeout: 15000,
        baseUrl: 'http://127.0.0.1:8000/api/'));
  }

  /// Add Dio Interceptor
  Dio addInterceptor(Dio dio) {
    return dio
      ..interceptors.add(InterceptorsWrapper(
          onRequest: (options, handler) => requestInterceptor(options, handler),
          onResponse: (Response response, handler) =>
              responseInterceptor(response, handler),
          onError: (DioError dioError, handler) =>
              errorInterceptor(dioError, handler)));
  }

  FutureOr<dynamic> requestInterceptor(RequestOptions options, handler) async {
    var token = await HiveDB().getFromBox('user_info', 'token');
    if (token != null) {
      options.headers.addAll({"Authorization": "Bearer " + token});
    }
    options.headers.addAll({"Content-Type": "application/json"});
    options.path = options.path;
    return handler.next(options);
  }

  FutureOr<dynamic> responseInterceptor(Response options, handler) async {
    return handler.next(options);
  }

  void errorInterceptor(DioError dioError, handler) {
    return handler.next(dioError);
  }

  String _handleError(DioError error) {
    String errorDescription = "";
    if (error is DioError) {
      switch (error.type) {
        case DioErrorType.cancel:
          errorDescription = "Request to API Server was cancelled";
          break;
        case DioErrorType.other:
          errorDescription = error.message;
          break;
        case DioErrorType.response:
          errorDescription = error.response!.data['message'].toString();
          break;
        default:
          errorDescription = "Something Wrong in connection";
      }
    } else {
      errorDescription = "Unexpected error occured";
    }
    log(errorDescription);
    return errorDescription;
  }
}
