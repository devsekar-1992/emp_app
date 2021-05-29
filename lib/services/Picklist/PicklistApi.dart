import 'package:dio/dio.dart';
import 'package:emp_app/Settings/Picklist/models/picklist_items_model.dart';
import 'package:emp_app/exceptions/auth_exceptions.dart';

import '../API/api.dart';

class PicklistApiRequest {
  Future<PicklistItemsModel> getPicklistItems() async {
    try {
      final response = await Api().getRequest('picklist/show', {});
      return PicklistItemsModel.fromJson(response.data);
    } on DioError catch (err) {
      print(err.message);
      throw AuthenticationException(
          message: err.response!.data['message'].toString());
    }
  }
}
