part of 'filtered_tasks_bloc.dart';

abstract class FilteredTasksState extends Equatable {
  const FilteredTasksState();

  @override
  List<Object> get props => [];
}

class FilteredTasksLoadInProgress extends FilteredTasksState {}

class FilteredTasksLoadSuccess extends FilteredTasksState {
  final List<Task> filteredTasks;
  final List<Task> allTasks;
  final VisibilityFilter activeFilter;
  final User user;

  const FilteredTasksLoadSuccess(
      this.filteredTasks, this.allTasks, this.activeFilter, this.user);

  @override
  List<Object> get props => [filteredTasks, allTasks, activeFilter, user];

  @override
  String toString() {
    return 'FilteredTasksLoadSuccess {user: $user, filteredTasks: $filteredTasks, allTasks: $allTasks,  activeFilter: $activeFilter}';
  }
}
