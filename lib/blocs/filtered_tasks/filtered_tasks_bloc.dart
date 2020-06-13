import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import 'package:appwrite_project/blocs/tasks/tasks_bloc.dart';
import 'package:appwrite_project/models/task.dart';
import 'package:appwrite_project/models/visibility_filter.dart';

part 'filtered_tasks_event.dart';
part 'filtered_tasks_state.dart';

class FilteredTasksBloc extends Bloc<FilteredTasksEvent, FilteredTasksState> {
  final TasksBloc tasksBloc;
  StreamSubscription tasksSubscription;

  FilteredTasksBloc({@required this.tasksBloc}) {
    tasksSubscription = tasksBloc.listen((state) {
      if (state is TasksLoadSuccess) {
        add(TasksUpdated((tasksBloc.state as TasksLoadSuccess).tasks));
      }
    });
  }

  @override
  FilteredTasksState get initialState {
    print('initial state');
    return tasksBloc.state is TasksLoadSuccess
        ? FilteredTasksLoadSuccess(
            (tasksBloc.state as TasksLoadSuccess).tasks,
            VisibilityFilter.all,
          )
        : FilteredTasksLoadInProgress();
  }

  @override
  Stream<FilteredTasksState> mapEventToState(FilteredTasksEvent event) async* {
    if (event is FilterUpdated) {
      yield* _mapFilterUpdatedToState(event);
    } else if (event is TasksUpdated) {
      yield* _mapTasksUpdatedToState(event);
    }
  }

  Stream<FilteredTasksState> _mapFilterUpdatedToState(
    FilterUpdated event,
  ) async* {
    if (tasksBloc.state is TasksLoadSuccess) {
      yield FilteredTasksLoadSuccess(
        _mapTasksToFilteredTasks(
          (tasksBloc.state as TasksLoadSuccess).tasks,
          event.filter,
        ),
        event.filter,
      );
    }
  }

  Stream<FilteredTasksState> _mapTasksUpdatedToState(
    TasksUpdated event,
  ) async* {
    final visibilityFilter = state is FilteredTasksLoadSuccess
        ? (state as FilteredTasksLoadSuccess).activeFilter
        : VisibilityFilter.all;
    yield FilteredTasksLoadSuccess(
      _mapTasksToFilteredTasks(
        (tasksBloc.state as TasksLoadSuccess).tasks,
        visibilityFilter,
      ),
      visibilityFilter,
    );
  }

  List<Task> _mapTasksToFilteredTasks(
      List<Task> tasks, VisibilityFilter filter) {
    return tasks.where((task) {
      if (filter == VisibilityFilter.all) {
        return true;
      } else if (filter == VisibilityFilter.active) {
        return !task.complete;
      } else {
        return task.complete;
      }
    }).toList();
  }

  @override
  Future<void> close() {
    tasksSubscription.cancel();
    return super.close();
  }
}
