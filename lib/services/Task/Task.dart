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

  Future saveTaskEdit(TaskForm taskInfo) async {
    final response = await Api().postRequest('task/update', taskInfo.toJson());
    return response;
  }
}
