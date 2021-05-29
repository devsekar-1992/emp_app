import 'package:emp_app/Tasks/bloc/detail/task_detail_state.dart';
import 'package:emp_app/Tasks/bloc/task_event.dart';
import 'package:emp_app/Tasks/bloc/task_state.dart';
import 'package:emp_app/Tasks/data/task_repository/task_repository.dart';
import 'package:emp_app/Tasks/models/task_detail_model.dart';
import 'package:emp_app/Tasks/models/task_list_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskDetailBloc extends Bloc<TaskEvent, TaskDetailState> {
  final TaskRespository taskRespository;

  TaskDetailBloc({required this.taskRespository}) : super(TaskDetailInitial());

  @override
  Stream<TaskDetailState> mapEventToState(TaskEvent event) async* {
    yield TaskDetailInitial();
    try {
      if (event is TaskDetail) {
        yield* _mapTaskDetailToState(event);
      }
    } catch (e) {}
  }

  Stream<TaskDetailState> _mapTaskDetailToState(TaskDetail event) async* {
    print('Detail Loading');
    yield TaskDetailLoading();
    try {
      final TaskDetailModel response =
          await this.taskRespository.getTaskDetails({'id': event.taskId});
      // ignore: unnecessary_null_comparison
      print(response);
      if (response != null) {
        yield TaskDetailSuccess(taskDetailModel: response);
      } else {
        yield TaskDetailFailure(detailError: 'Something Went Wrong');
      }
    } catch (e) {
      print(e.toString());
      yield TaskDetailFailure(detailError: e.toString());
    }
  }
}
