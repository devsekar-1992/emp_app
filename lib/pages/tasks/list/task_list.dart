// import 'package:emp_app/Tasks/bloc/task_bloc.dart';
// import 'package:emp_app/Tasks/bloc/task_event.dart';
// import 'package:emp_app/Tasks/bloc/task_state.dart';
// import 'package:emp_app/Tasks/data/task_repository/task_repository.dart';
// import 'package:emp_app/Tasks/models/task_list_model.dart';
// import 'package:emp_app/services/Task/Task.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class TaskList extends StatefulWidget {
//   @override
//   _TaskListState createState() => _TaskListState();
// }

// class _TaskListState extends State<TaskList> {
//   // ignore: unused_field
//   TaskListModel? _taskList;
//   @override
//   void initState() {
//     super.initState();
//     getTaskItems();
//   }

//   getTaskItems() async {
//     _taskList = (await TaskRequest().getTaskList());
//   }

//   Widget build(BuildContext context) {
//     final taskRespository = TaskRespository(taskRequest: TaskRequest());
//     if (_taskList != null) {
//       return Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: BlocProvider<TaskBloc>(
//             create: (context) => TaskBloc(taskRespository: taskRespository),
//             child: makeBody(),
//           ));
//     }
//     return CircularProgressIndicator();
//   }
// }

// Widget makeBody() {
//   return BlocBuilder<TaskBloc, TaskListState>(
//     builder: (context, state) {
//       if (state is TaskListLoading) {
//         return CircularProgressIndicator();
//       }
//       return Container();
//     },
//   );
// }

// Card makeCard(Data data) => Card(
//     elevation: 8.0,
//     margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//     child: Container(
//       decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
//       child: ListTile(
//         contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
//         title: Text(
//           data.taskName,
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//         ),
//         // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

//         subtitle: Row(
//           children: <Widget>[
//             Icon(Icons.api, color: Colors.blue),
//             Text(data.taskAssigneeDetails.name,
//                 style: TextStyle(color: Colors.white)),
//             Icon(Icons.cabin, color: Colors.amberAccent),
//             Text(data.taskDetails.taskVersion,
//                 style: TextStyle(color: Colors.white)),
//             Icon(Icons.date_range, color: Colors.redAccent),
//             Text(data.taskCreatedAt, style: TextStyle(color: Colors.white)),
//             Icon(Icons.production_quantity_limits, color: Colors.tealAccent),
//             Text(data.taskDetails.taskProject,
//                 style: TextStyle(color: Colors.white))
//           ],
//         ),
//       ),
//     ));
