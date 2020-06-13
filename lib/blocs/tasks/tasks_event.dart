part of 'tasks_bloc.dart';

abstract class TasksEvent extends Equatable {
  const TasksEvent();

  @override
  List<Object> get props => [];
}

// Task loaded
class TasksLoaded extends TasksEvent {}

// Task added
class TaskAdded extends TasksEvent {
  final Task task;

  const TaskAdded(this.task);

  @override
  String toString() => 'TaskAdded {task: $task}';
}

// Task Updated
class TaskUpdated extends TasksEvent {
  final Task task;

  const TaskUpdated(this.task);

  @override
  List<Object> get props => [task];

  @override
  String toString() => 'TaskUpdated { task: $task }';
}

// Task Deleted
class TaskDeleted extends TasksEvent {
  final Task task;

  const TaskDeleted(this.task);

  @override
  List<Object> get props => [task];

  @override
  String toString() => 'TaskDeleted { task: $task }';
}

// Task Completed
class Completed extends TasksEvent {}

// Task Toggle
class Toggle extends TasksEvent {}

// Task Favorite
class Favourite extends TasksEvent {}
