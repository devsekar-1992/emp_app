import 'package:emp_app/Tasks/bloc/detail/task_detail_state.dart';
import 'package:emp_app/Tasks/bloc/task_bloc.dart';
import 'package:emp_app/Tasks/bloc/task_event.dart';
import 'package:emp_app/Tasks/bloc/task_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class TaskDetailView extends StatefulWidget {
  late int taskId;
  TaskDetailView({required this.taskId});

  @override
  _TaskDetailViewState createState() => _TaskDetailViewState();
}

class _TaskDetailViewState extends State<TaskDetailView> {
  @override
  Widget build(BuildContext context) {
    context.read<TaskBloc>().add(TaskDetail(taskId: widget.taskId));
    return Container(
      child: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          print('Detail');
          print(state);
          if (state is TaskLoading) {
            return CircularProgressIndicator();
          }
          if (state is TaskSuccess) {
            final response = state.taskModels[0];
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 200.0,
                  title: Text(response.taskName),
                ),
                // SliverList(
                //     delegate: SliverChildBuilderDelegate((context, index) {
                //   if (response.taskReview!.isNotEmpty) {
                //     return Container(
                //       child:
                //           Text(response.taskReview![index].userId.toString()),
                //     );
                //   }
                //   return Container(child: Text('No Task Review'));
                // }, childCount: response.taskReview!.length))
              ],
            );
          }
          if (state is TaskDetailFailure) {
            return Container(
              child: Text('Failed to load data' + state.detailError),
            );
          }
          print(state);
          return Container(
            child: Text('Task Detail' + widget.taskId.toString()),
          );
        },
      ),
    );
  }
}
