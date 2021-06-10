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
        body: Container(
          child: Text('Container'),
        ));
  }

  Container bottomNavigator() {
    int currentTab = 0;
    return Container(
      height: 55,
      child: BottomNavigationBar(
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.task), label: 'Task'),
          BottomNavigationBarItem(
              icon: Icon(Icons.checklist_outlined), label: 'Checklist')
        ],
        onTap: (index) {
          print(index);
          setState(() {
            currentTab = index;
          });
        },
        currentIndex: currentTab,
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
