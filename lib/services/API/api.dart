import 'package:dio/dio.dart';
import 'dart:developer';
import 'Interceptors.dart';

class Api {
  postRequest(path, postData) {
    Dio dio;
    dio = new AppInterceptors().createDio();
    dio = new AppInterceptors().addInterceptor(dio);
    return dio.post(path, data: postData);
  }

  getRequest(path, getData) {
    log('path');
    print(getData);
    Dio dio;
    dio = new AppInterceptors().createDio();
    dio = new AppInterceptors().addInterceptor(dio);
    if (getData != '') {
      return dio.get(path, queryParameters: getData);
    } else {
      return dio.get(path);
    }
  }
}
