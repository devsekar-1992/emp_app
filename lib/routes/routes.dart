import 'package:emp_app/Checklist/bloc/review_checklist_bloc.dart';
import 'package:emp_app/Checklist/data/checklist_repository.dart';
import 'package:emp_app/Checklist/view/checklist_list.dart';
import 'package:emp_app/Checklist/view/review_list.dart';
import 'package:emp_app/Shared/Error/error_screen.dart';
import 'package:emp_app/Tasks/bloc/task_bloc.dart';
import 'package:emp_app/Tasks/view/task_view.dart';
import 'package:emp_app/pages/home/home.dart';
import 'package:emp_app/services/Checklist/Checklist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:emp_app/services/Task/Task.dart';
import 'package:emp_app/Tasks/data/task_repository/task_repository.dart';

class AppNavigator extends StatefulWidget {
  AppNavigator({required this.routes});
  final String routes;
  @override
  _AppNavigatorState createState() => _AppNavigatorState();
}

class _AppNavigatorState extends State<AppNavigator> {
  @override
  Widget build(BuildContext context) {
    String path;
    return Navigator(
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            settings: settings,
            builder: (_) {
              if (settings.name != '/') {
                path = settings.name!;
              } else {
                path = widget.routes;
              }
              switch (path) {
                case 'task':
                  return BlocProvider<TaskBloc>(
                    create: (context) => TaskBloc(
                        taskRespository:
                            TaskRespository(taskRequest: TaskRequest())),
                    child: TaskListPage(),
                  );
                case 'review_checklist':
                  return BlocProvider(
                    create: (context) => ReviewChecklistBloc(
                        checklistRepository: ChecklistRepository(
                            checklistRequest: ChecklistRequest())),
                    child: ChecklistListView(),
                  );
                case 'review_list':
                  return ReviewList(reviewTitle: settings.arguments.toString());
                default:
                  return ErrorScreen();
              }
            });
      },
    );
  }
}
