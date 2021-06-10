import 'package:emp_app/Shared/Layout/models/task_navigator_model.dart';
import 'package:emp_app/routes/routes.dart';
import 'package:flutter/material.dart';

class LayoutScreen extends StatefulWidget {
  @override
  _LayoutScreenState createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          top: false,
          child: AppNavigator(
            routes: taskBottomNavigator[_currentIndex].routes,
          )),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int newValue) {
          setState(() {
            _currentIndex = newValue;
          });
        },
        items: taskBottomNavigator
            .map((TaskNavigatorModel e) => BottomNavigationBarItem(
                icon: Icon(e.naviIcon), label: e.naviLabel))
            .toList(),
      ),
    );
  }
}
