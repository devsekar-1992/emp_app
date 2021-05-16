import 'package:emp_app/Tasks/models/task_detail_model.dart';

import '../task_state.dart';

class TaskDetailInitial extends TaskState {}

class TaskDetailLoading extends TaskState {}

class TaskDetailSuccess extends TaskState {
  final TaskDetailModel taskDetailModel;
  TaskDetailSuccess({required this.taskDetailModel});
  @override
  List<Object> get props => [taskDetailModel];
}

class TaskDetailFailure extends TaskState {
  final String detailError;
  TaskDetailFailure({required this.detailError});
}
