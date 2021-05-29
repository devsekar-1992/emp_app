import 'package:emp_app/Tasks/bloc/task_bloc.dart';
import 'package:emp_app/Tasks/bloc/task_event.dart';
import 'package:emp_app/Tasks/bloc/task_state.dart';
import 'package:emp_app/Tasks/view/task_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('taskList');
    context.read<TaskBloc>().add(TaskList());
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        print('remove build');
        print(state);
        if (state is TaskInitial) {}
        if (state is TaskLoading) {
          print('loading');
          return CircularProgressIndicator();
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
    );
  }
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
          return CircularProgressIndicator();
        }),
  );
}

Card makeCard(context, data) => Card(
    elevation: 8.0,
    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    child: InkWell(
      onTap: () {
        BlocProvider.of<TaskBloc>(context).close();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TaskDetailView(taskId: data.taskId)));
      },
      child: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
        child: ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          title: Text(
            data.taskName,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

          subtitle: Row(
            children: <Widget>[
              Icon(Icons.api, color: Colors.blue),
              Text(data.taskAssigneeDetails.name,
                  style: TextStyle(color: Colors.white)),
              Icon(Icons.cabin, color: Colors.amberAccent),
              Text(data.taskDetails.taskVersion,
                  style: TextStyle(color: Colors.white)),
              Icon(Icons.date_range, color: Colors.redAccent),
              Text(data.taskCreatedAt, style: TextStyle(color: Colors.white)),
              Icon(Icons.production_quantity_limits, color: Colors.tealAccent),
              Text(data.taskDetails.taskProject,
                  style: TextStyle(color: Colors.white))
            ],
          ),
        ),
      ),
    ));
