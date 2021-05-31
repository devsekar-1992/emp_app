import 'package:emp_app/Tasks/bloc/task_bloc.dart';
import 'package:emp_app/Tasks/data/task_repository/task_repository.dart';
import 'package:emp_app/Tasks/task.dart';
import 'package:emp_app/services/Task/Task.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        appBar: homeAppBar(),
        bottomNavigationBar: bottomNavigator(),
        body: BlocProvider<TaskBloc>(
          create: (context) => TaskBloc(
              taskRespository: TaskRespository(taskRequest: TaskRequest())),
          child: TaskListPage(),
        ));
  }

  Container bottomNavigator() {
    return Container(
      height: 55,
      child: BottomAppBar(
        color: Color.fromRGBO(58, 66, 86, 1.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                onPressed: null,
                icon: Icon(
                  Icons.task,
                  color: Colors.white,
                )),
            IconButton(
                onPressed: null,
                icon: Icon(
                  Icons.checklist,
                  color: Colors.white,
                )),
            IconButton(
                onPressed: null,
                icon: Icon(
                  Icons.contacts,
                  color: Colors.white,
                )),
            IconButton(
                onPressed: null,
                icon: Icon(
                  Icons.verified_user,
                  color: Colors.white,
                ))
          ],
        ),
      ),
    );
  }

  AppBar homeAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      title: Text('Task Page'),
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
    );
  }
}
