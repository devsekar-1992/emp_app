import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:emp_app/exceptions/auth_exceptions.dart';
import 'package:emp_app/helpers/db/db_helpers.dart';
import 'package:emp_app/Login/models/user_model.dart';

import '../API/api.dart';

class AuthRequest {
  Future<UserModel> login(authData) async {
    log(authData.toString());
    try {
      final response =
          await Api().postRequest('user/auth', jsonEncode(authData));
      return UserModel.fromJson(response.data);
    } on DioError catch (err) {
      print(err.message);
      throw AuthenticationException(
          message: err.response!.data['message'].toString());
    }
  }

  Future<String> isAuthenticated() async {
    var data = await HiveDB().getFromBox('user_model', 'um');
    print('data');
    if (data != null) {
      final dd = jsonDecode(data);
      HiveDB().putIntoBox('user_info', 'token', dd['token']);
      return data;
    }
    return 'no';
  }

  Future<String?> getCurrentUserId() async {
    var data = await HiveDB().getFromBox('user_model', 'um');
    if (data != null) {
      return data.toString();
    }
    return null;
  }

  logout() {}
}
