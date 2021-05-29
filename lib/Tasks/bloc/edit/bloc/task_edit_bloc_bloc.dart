import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:emp_app/Tasks/data/task_repository/task_repository.dart';
import 'package:emp_app/Tasks/models/task_edit_model.dart';
import 'package:equatable/equatable.dart';

part 'task_edit_bloc_event.dart';
part 'task_edit_bloc_state.dart';

class TaskEditBlocBloc extends Bloc<TaskEditBlocEvent, TaskEditBlocState> {
  TaskRespository taskRespository;
  TaskEditBlocBloc({required this.taskRespository})
      : super(TaskEditBlocInitial());

  @override
  Stream<TaskEditBlocState> mapEventToState(
    TaskEditBlocEvent event,
  ) async* {
    print(event);
    if (event is TaskEdit) {
      yield* _mapTaskEditToState(event);
    }
    if (event is TaskEditBackEvent) {
      yield TaskEditBlocInitial();
    }
    if (event is CreateTask) {
      try {
        print('Events' + event.taskForm.toString());
        await taskRespository.saveTaskInfo(event.taskForm);
        print('Events finish');
        yield TaskEditBlocSuccessSave();
      } catch (e) {}
    }
  }

  Stream<TaskEditBlocState> _mapTaskEditToState(TaskEdit event) async* {
    yield TaskEditBlocLoading();
    try {
      print(event.taskId);
      yield TaskEditBlocSuccess();
    } catch (e) {}
  }
}
