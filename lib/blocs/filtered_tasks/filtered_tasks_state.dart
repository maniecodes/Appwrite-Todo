part of 'filtered_tasks_bloc.dart';

abstract class FilteredTasksState extends Equatable {
  const FilteredTasksState();

  @override
  List<Object> get props => [];
}

class FilteredTasksLoadInProgress extends FilteredTasksState {}

class FilteredTasksLoadSuccess extends FilteredTasksState {
  final List<Task> filteredTasks;
  final VisibilityFilter activeFilter;

  const FilteredTasksLoadSuccess(this.filteredTasks, this.activeFilter);

  @override
  List<Object> get props => [filteredTasks, activeFilter];

  @override
  String toString() {
    return 'FilteredTasksLoadSuccess {filteredTasks: $filteredTasks, activeFilter: $activeFilter}';
  }
}
