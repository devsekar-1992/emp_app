import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:emp_app/Settings/Picklist/models/picklist_items_model.dart';
import 'package:emp_app/Tasks/data/task_repository/task_repository.dart';
import 'package:emp_app/Tasks/models/task_edit_model.dart';

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
        final response = await taskRespository.saveTaskInfo(event.taskForm);
        print('Events finish');
        print(response.data['data']);
        yield TaskEditBlocSuccessSave(message: response.data['data']);
      } catch (e) {
        yield TaskEditBlocFailure(error: e.toString());
      }
    }
    if (event is TaskUpdate) {}
  }

  Stream<TaskEditBlocState> _mapTaskEditToState(TaskEdit event) async* {
    yield TaskEditBlocLoading();
    try {
      final PicklistItemsModel responsePicklist =
          await taskRespository.loadPickListData();
      TaskEditModel response;
      if (event.requestType == 'update') {
        response = await taskRespository.getTaskReview(event.taskId);

        if (response != null) {
          yield TaskEditBlocSuccess(response.data[0], responsePicklist.data);
        } else {
          yield TaskEditBlocFailure(error: 'Something Went Wrong');
        }
      } else {
        EditData response = EditData();
        yield TaskEditBlocSuccess(response, responsePicklist.data);
      }
    } catch (e) {
      yield TaskEditBlocFailure(error: e.toString());
    }
  }

  Stream<TaskEditBlocState> _mapTaskUpdateToState(TaskUpdate event) async* {
    yield TaskEditBlocLoading();
    try {} catch (e) {
      print('Catch');
      print(e.toString());
    }
  }
}
