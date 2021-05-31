import 'dart:convert';

import 'package:emp_app/Settings/Picklist/models/picklist_items_model.dart';
import 'package:emp_app/Tasks/models/task_detail_model.dart';
import 'package:emp_app/Tasks/models/task_edit_model.dart';
import 'package:emp_app/Tasks/models/task_list_model.dart';

import '../API/api.dart';

class TaskRequest {
  Future<TaskListModel> getTaskList() async {
    final response = await Api().getRequest('task/list', '');
    return TaskListModel.fromJson(response.data);
  }

  Future<TaskDetailModel> getTaskDetailModel(taskId) async {
    final response = await Api().getRequest('task/view', {'id': taskId['id']});
    return TaskDetailModel.fromJson(response.data);
  }

  Future<TaskEditModel> getTaskReviewData(taskReviewId) async {
    final response = await Api().getRequest('task/edit', {'id': taskReviewId});
    return TaskEditModel.fromJson(response.data);
  }

  Future<PicklistItemsModel> getPicklistList() async {
    final picklistResponse = await Api().getRequest('picklist/list', '');
    return PicklistItemsModel.fromJson(picklistResponse.data);
  }

  Future saveTaskEdit(EditData taskInfo) async {
    final response = await Api().postRequest('task/update', taskInfo.toJson());
    return response;
  }
}
