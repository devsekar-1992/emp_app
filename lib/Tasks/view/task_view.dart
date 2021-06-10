import 'package:emp_app/Tasks/bloc/detail/task_detail_bloc.dart';
import 'package:emp_app/Tasks/bloc/edit/bloc/task_edit_bloc_bloc.dart';
import 'package:emp_app/Tasks/bloc/task_bloc.dart';
import 'package:emp_app/Tasks/bloc/task_event.dart';
import 'package:emp_app/Tasks/bloc/task_state.dart';
import 'package:emp_app/Tasks/data/task_repository/task_repository.dart';
import 'package:emp_app/Tasks/view/task_detail.dart';
import 'package:emp_app/services/Task/Task.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:timeago/timeago.dart' as timeago;

class TaskListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<TaskBloc>().add(TaskList());
    return Scaffold(
      appBar: AppBar(
        title: Text('Tasks'),
        elevation: 0,
        backgroundColor: Color.fromRGBO(64, 75, 96, .9),
      ),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is TaskInitial) {}
          if (state is TaskLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is TaskSuccess) {
            return makeBody(context, state.taskModels);
          }
          if (state is TaskFailure) {
            print(state.error);
          }
          return Container(
            child: Text('No List view'),
          );
        },
      ),
      floatingActionButton: _speedDialTaskList(context),
    );
  }
}

SpeedDial _speedDialTaskList(context) {
  return SpeedDial(
    icon: Icons.add,
    activeIcon: Icons.remove,
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
    children: [
      SpeedDialChild(
          child: Icon(Icons.add),
          backgroundColor: Colors.purple,
          label: 'Add Task',
          onTap: () {}),
      SpeedDialChild(
        child: Icon(Icons.sync),
        backgroundColor: Colors.indigoAccent,
        label: 'Sync With Valor Tracker',
        onTap: () {},
      )
    ],
  );
}

Container makeBody(context, items) {
  return Container(
    child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          if (items != null) {
            return makeCard(context, items[index]);
          }
          return Center(child: CircularProgressIndicator());
        }),
  );
}

Card makeCard(context, data) => Card(
    color: Color.fromRGBO(64, 75, 96, .9),
    elevation: 5.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
    margin: EdgeInsets.all(20.0),
    child: InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MultiBlocProvider(providers: [
                BlocProvider<TaskDetailBloc>(
                    create: (context) => TaskDetailBloc(
                        taskRespository:
                            TaskRespository(taskRequest: TaskRequest()))),
                BlocProvider<TaskEditBlocBloc>(
                    create: (context) => TaskEditBlocBloc(
                        taskRespository:
                            TaskRespository(taskRequest: TaskRequest()))),
              ], child: TaskDetailView(taskId: data.taskId)),
            ));
      },
      child: Container(
        padding: EdgeInsets.only(top: 10),
        child: ListTile(
          mouseCursor: MouseCursor.defer,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 15),
                child: Text(
                  data.taskName,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                  timeago.format(DateTime.parse(data.taskCreatedAt)).toString(),
                  style: TextStyle(color: Colors.white)),
            ],
          ),
          subtitle: Container(
            padding: EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[
                Align(
                  child: Icon(Icons.account_circle, color: Colors.blue),
                ),
                Container(
                  margin: EdgeInsets.only(left: 5.0, right: 10, top: 2),
                  child: Text(data.taskAssigneeDetails.name,
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.white)),
                ),
                Align(
                  child: Icon(Icons.cabin, color: Colors.amberAccent),
                ),
                Container(
                  margin: EdgeInsets.only(left: 5.0, right: 10, top: 2),
                  child: Text(data.taskDetails.taskVersion,
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.white)),
                ),
                Align(
                    child: Icon(Icons.production_quantity_limits,
                        color: Colors.tealAccent)),
                Container(
                  margin: EdgeInsets.only(left: 5.0, right: 10, top: 2),
                  child: Text(data.taskDetails.taskProject,
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
