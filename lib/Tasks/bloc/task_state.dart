import 'package:emp_app/Tasks/models/task_detail_model.dart';
import 'package:emp_app/Tasks/models/task_list_model.dart';
import 'package:equatable/equatable.dart';

abstract class TaskState {
  List<Object> get props => [];
}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TaskSuccess extends TaskState {
  final String viewType;
  late final List<dynamic> taskModels;
  TaskSuccess({required this.taskModels, required this.viewType});

  @override
  List<Object> get props => [taskModels];
}

class TaskFailure extends TaskState {
  final String error;
  TaskFailure({required this.error});
}
