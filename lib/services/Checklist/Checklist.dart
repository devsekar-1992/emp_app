import 'dart:convert';

import 'package:emp_app/Checklist/models/review_checklist_model.dart';
import 'package:emp_app/Settings/Picklist/models/picklist_items_model.dart';
import 'package:emp_app/helpers/db/db_helpers.dart';
import 'package:emp_app/services/API/api.dart';

class ChecklistRequest {
  Future<ReviewChecklistData> getReviewChecklistList() async {
    final json = await Api().getRequest('review_checklist/list', '');
    return ReviewChecklistData.fromJson(json.data);
  }

  Future<PicklistItemsModel> getPicklistList() async {
    final picklistData = await HiveDB().getFromBox('picklist_data', 'data');
    //final picklistData = null;
    final picklistResponse;
    print(picklistData);
    if (picklistData == null) {
      print('Fresh Picklist');
      picklistResponse = await Api().getRequest('picklist/list', '');
      await HiveDB().putIntoBox(
          'picklist_data', 'data', jsonEncode(picklistResponse.data));
      return PicklistItemsModel.fromJson(picklistResponse.data);
    } else {
      print('Already Picklist');
      picklistResponse = jsonDecode(picklistData);
      print(picklistResponse);
      return PicklistItemsModel.fromJson(picklistResponse);
    }
  }
}
