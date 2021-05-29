import 'package:emp_app/Tasks/bloc/task_event.dart';
import 'package:emp_app/Tasks/bloc/task_state.dart';
import 'package:emp_app/Tasks/data/task_repository/task_repository.dart';
import 'package:emp_app/Tasks/models/task_list_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRespository taskRespository;

  TaskBloc({required this.taskRespository}) : super(TaskInitial());

  @override
  Stream<TaskState> mapEventToState(TaskEvent event) async* {
    yield TaskInitial();
    try {
      print(event);
      if (event is TaskList) {
        yield* _mapTaskListToState(event);
      }
    } catch (e) {}
  }

  Stream<TaskState> _mapTaskListToState(TaskList event) async* {
    yield TaskLoading();
    try {
      final TaskListModel response = await this.taskRespository.getTaskItems();
      // ignore: unnecessary_null_comparison
      if (response != null) {
        yield TaskSuccess(taskModels: response.data, viewType: 'list');
      } else {
        yield TaskFailure(error: 'Something Went Wrong');
      }
    } catch (e) {
      yield TaskFailure(error: e.toString());
    }
  }
}
