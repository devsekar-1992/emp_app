import 'package:emp_app/Tasks/models/task_detail_model.dart';
import 'package:emp_app/services/Task/Task.dart';

import '../../models/task_list_model.dart';

class TaskRespository {
  late final TaskRequest taskRequest;
  TaskRespository({required this.taskRequest});
  Future<TaskListModel> getTaskItems() => taskRequest.getTaskList();

  Future<TaskDetailModel> getTaskDetails(taskId) =>
      taskRequest.getTaskDetailModel(taskId);
}
