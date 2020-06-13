part of 'filtered_tasks_bloc.dart';


abstract class FilteredTasksEvent extends Equatable {
  const FilteredTasksEvent();
}

class FilterUpdated extends FilteredTasksEvent {
  final VisibilityFilter filter;

  const FilterUpdated(this.filter);

  @override
  List<Object> get props => [filter];

  @override
  String toString() => 'FilterUpdated { filter: $filter }';
}

class TasksUpdated extends FilteredTasksEvent {
  final List<Task> tasks;

  const TasksUpdated(this.tasks);

  @override
  List<Object> get props => [tasks];

  @override
  String toString() => 'TasksUpdated { tasks: $tasks }';
}
