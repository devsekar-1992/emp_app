import 'package:emp_app/Tasks/bloc/detail/task_detail_bloc.dart';
import 'package:emp_app/Tasks/bloc/detail/task_detail_state.dart';
import 'package:emp_app/Tasks/bloc/task_event.dart';
import 'package:emp_app/Tasks/view/task_edit.dart';
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
  void initState() {
    context.read<TaskDetailBloc>().add(TaskDetail(taskId: widget.taskId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('Detailview');

    return Scaffold(
      body: Container(
        child: BlocBuilder<TaskDetailBloc, TaskDetailState>(
          builder: (context, state) {
            print('State');
            print(state);
            if (state is TaskDetailInitial) {}
            if (state is TaskDetailLoading) {
              return CircularProgressIndicator();
            }
            if (state is TaskDetailSuccess) {
              final response = state.taskDetailModel.data[0];
              print(response);
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    expandedHeight: 200.0,
                    title: Text(response.taskName),
                  ),
                  SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                    if (response.taskReview!.isNotEmpty) {
                      return Card(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        elevation: 10.0,
                        child: InkWell(
                          onTap: () {
                            BlocProvider.of<TaskDetailBloc>(context).close();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TaskEditView(
                                          taskId: widget.taskId,
                                          taskReviewId: response
                                              .taskReview![index].reviewId,
                                        )));
                          },
                          child: Container(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Task Review Status',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18),
                                    ),
                                    Text(
                                      'Task Review Type',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18),
                                    ),
                                    Text(
                                      'Reviewed Date',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(response
                                        .taskReview![index].status.status
                                        .toString()),
                                    Text(response.taskReview![index].reviewType
                                        .toString()),
                                    Text(response.taskReview![index].reviewDate
                                        .toString()),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                    return Container(child: Text('No Task Review'));
                  }, childCount: response.taskReview!.length)),
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
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: FloatingActionButton(
              onPressed: () {
                BlocProvider.of<TaskDetailBloc>(context).close();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TaskEditView(
                              taskId: widget.taskId,
                              taskReviewId: 0,
                            )));
              },
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
