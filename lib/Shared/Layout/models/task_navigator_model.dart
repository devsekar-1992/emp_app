import 'package:flutter/material.dart';

class TaskNavigatorModel {
  const TaskNavigatorModel(this.naviLabel, this.naviIcon, this.routes);

  final String naviLabel;
  final IconData naviIcon;
  final String routes;
}

const List<TaskNavigatorModel> taskBottomNavigator = <TaskNavigatorModel>[
  TaskNavigatorModel('Task', Icons.task, 'task'),
  TaskNavigatorModel('Review Checklist', Icons.checklist, 'review_checklist'),
  TaskNavigatorModel('Profile', Icons.account_circle, 'profile'),
];
