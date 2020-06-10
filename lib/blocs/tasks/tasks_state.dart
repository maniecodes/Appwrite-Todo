import 'package:equatable/equatable.dart';
import 'package:appwrite_project/models/models.dart';

abstract class TasksState extends Equatable {
  const TasksState();

  @override
  List<Object> get props => [];
}

class TasksLoadInProgress extends TasksState {}

class TasksLoadSuccess extends TasksState {
  final List<Task> tasks;

  const TasksLoadSuccess([this.tasks = const []]);

  @override
  List<Object> get props => [tasks];

  @override
  String toString() => 'TasksLoadSuccess {tasks: $tasks}';
}

class TasksLoadFailure extends TasksState {}
