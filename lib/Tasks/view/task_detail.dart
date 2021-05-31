import 'package:emp_app/Tasks/bloc/detail/task_detail_bloc.dart';
import 'package:emp_app/Tasks/bloc/detail/task_detail_state.dart';
import 'package:emp_app/Tasks/bloc/edit/bloc/task_edit_bloc_bloc.dart';
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
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  late TaskDetailBloc taskDetailBloc;
  late TaskEditBlocBloc taskEditBlocBloc;
  @override
  Widget build(BuildContext context) {
    taskDetailBloc = context.read<TaskDetailBloc>();
    taskEditBlocBloc = context.read<TaskEditBlocBloc>();
    return Scaffold(
        key: _scaffoldKey,
        body: BlocListener<TaskEditBlocBloc, TaskEditBlocState>(
          listener: (context, state) {},
          child: BlocBuilder<TaskDetailBloc, TaskDetailState>(
            builder: (context, state) {
              if (state is TaskDetailInitial) {
                taskDetailBloc.add(TaskDetail(taskId: widget.taskId));
              }
              if (state is TaskDetailLoading) {
                return CircularProgressIndicator();
              }
              if (state is TaskDetailSuccess) {
                final response = state.taskDetailModel.data[0];
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
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MultiBlocProvider(
                                              providers: [
                                                BlocProvider<
                                                        TaskEditBlocBloc>.value(
                                                    value: taskEditBlocBloc
                                                      ..add(TaskEdit(
                                                          taskId: response
                                                              .taskReview![
                                                                  index]
                                                              .reviewId))),
                                                BlocProvider<
                                                        TaskDetailBloc>.value(
                                                    value: taskDetailBloc)
                                              ],
                                              child: TaskEditView(
                                                taskId: widget.taskId,
                                                taskReviewId: response
                                                    .taskReview![index].taskId,
                                              ))));
                            },
                            child: Container(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
                                      Text(response
                                          .taskReview![index].reviewType
                                          .toString()),
                                      Text(response
                                          .taskReview![index].reviewDate
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MultiBlocProvider(
                                  providers: [
                                    BlocProvider<TaskEditBlocBloc>.value(
                                        value: taskEditBlocBloc
                                          ..add(
                                              TaskEdit(taskId: widget.taskId))),
                                    BlocProvider<TaskDetailBloc>.value(
                                        value: taskDetailBloc)
                                  ],
                                  child: TaskEditView(
                                    taskId: widget.taskId,
                                    taskReviewId: 0,
                                  ))));
                },
                child: Icon(Icons.add),
              ),
            ),
          ],
        ));
  }
}
