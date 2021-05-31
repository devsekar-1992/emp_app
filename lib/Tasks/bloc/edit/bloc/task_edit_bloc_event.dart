part of 'task_edit_bloc_bloc.dart';

abstract class TaskEditBlocEvent {
  const TaskEditBlocEvent();

  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class TaskEdit extends TaskEditBlocEvent {
  late int taskId;
  TaskEdit({required this.taskId});

  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class CreateTask extends TaskEditBlocEvent {
  EditData taskForm;
  CreateTask({required this.taskForm});
  @override
  List<Object> get props => [];
}

class TaskEditBackEvent extends TaskEditBlocEvent {}
