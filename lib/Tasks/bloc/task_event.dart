import "package:equatable/equatable.dart";

abstract class TaskEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class TaskList extends TaskEvent {
  TaskList();

  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class TaskDetail extends TaskEvent {
  late int taskId;
  TaskDetail({required this.taskId});

  @override
  List<Object> get props => [];
}
