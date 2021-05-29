import 'package:emp_app/Tasks/models/task_detail_model.dart';
import 'package:equatable/equatable.dart';

abstract class TaskDetailState extends Equatable {
  @override
  List<Object> get props => [];
}

class TaskDetailInitial extends TaskDetailState {}

class TaskDetailLoading extends TaskDetailState {}

class TaskDetailSuccess extends TaskDetailState {
  final TaskDetailModel taskDetailModel;
  TaskDetailSuccess({required this.taskDetailModel});
  @override
  List<Object> get props => [taskDetailModel];
}

class TaskDetailFailure extends TaskDetailState {
  final String detailError;
  TaskDetailFailure({required this.detailError});
}
