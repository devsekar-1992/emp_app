part of 'task_edit_bloc_bloc.dart';

abstract class TaskEditBlocState {
  @override
  List<Object> get props => [];
}

class TaskEditBlocInitial extends TaskEditBlocState {}

class TaskEditBlocLoading extends TaskEditBlocState {}

class TaskEditBlocSuccess extends TaskEditBlocState {
  final EditData taskEditModel;
  final PicklistData picklistData;
  TaskEditBlocSuccess(
      {required this.taskEditModel, required this.picklistData});
  @override
  List<Object> get props => [taskEditModel];
}

class TaskEditBlocSuccessSave extends TaskEditBlocState {}

class TaskEditBlocFailure extends TaskEditBlocState {}
