import "package:equatable/equatable.dart";

abstract class TaskEvent {}

class TaskList extends TaskEvent {
  TaskList();
}

// ignore: must_be_immutable
class TaskDetail extends TaskEvent {
  late int taskId;
  TaskDetail({required this.taskId});
}
