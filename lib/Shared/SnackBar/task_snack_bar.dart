import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TaskSnackBar extends StatelessWidget {
  TaskSnackBar({required this.message});
  String message;
  @override
  Widget build(BuildContext context) {
    final snackBar = SnackBar(content: Text(this.message));
    return Scaffold(body: snackBar);
  }
}
