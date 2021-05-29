part of 'task_edit_bloc_bloc.dart';

abstract class TaskEditBlocState extends Equatable {
  const TaskEditBlocState();

  @override
  List<Object> get props => [];
}

class TaskEditBlocInitial extends TaskEditBlocState {}

class TaskEditBlocLoading extends TaskEditBlocState {}

class TaskEditBlocSuccess extends TaskEditBlocState {}

class TaskEditBlocSuccessSave extends TaskEditBlocState {}

class TaskEditBlocFailure extends TaskEditBlocState {}
