part of 'tasks_bloc.dart';

abstract class TasksState extends Equatable {
  const TasksState();

  @override
  List<Object> get props => [];
}

class TasksLoadInProgress extends TasksState {}

class TasksLoadSuccess extends TasksState {
  final List<Task> tasks;
  final User user;

  const TasksLoadSuccess([this.tasks = const [], this.user]);

  @override
  List<Object> get props => [tasks];

  @override
  String toString() => 'TasksLoadSuccess {tasks: $tasks, user: $user}';
}

class TasksLoadFailure extends TasksState {}
