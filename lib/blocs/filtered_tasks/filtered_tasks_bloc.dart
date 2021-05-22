import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import '../../blocs/blocs.dart';
import '../../models/models.dart';
import '../../resources/repository.dart';

part 'filtered_tasks_event.dart';
part 'filtered_tasks_state.dart';

class FilteredTasksBloc extends Bloc<FilteredTasksEvent, FilteredTasksState> {
  final TasksBloc tasksBloc;
  StreamSubscription tasksSubscription;
  final TasksRepositoryFlutter tasksRepository;
  final UserRepositoryFlutter userRepository;

  FilteredTasksBloc(
      {@required this.tasksBloc,
      @required this.tasksRepository,
      @required this.userRepository})
      : super(tasksBloc.state is TasksLoadSuccess
            ? FilteredTasksLoadSuccess(
                (tasksBloc.state as TasksLoadSuccess).tasks,
                (tasksBloc.state as TasksLoadSuccess).tasks,
                VisibilityFilter.all,
                (tasksBloc.state as TasksLoadSuccess).user)
            : FilteredTasksLoadInProgress()) {
    tasksSubscription = tasksBloc.stream.listen((state) {
      if (state is TasksLoadSuccess) {
        add(TasksUpdated((tasksBloc.state as TasksLoadSuccess).tasks,
            (tasksBloc.state as TasksLoadSuccess).user));
      }
    });
  }

  @override
  Stream<FilteredTasksState> mapEventToState(FilteredTasksEvent event) async* {
    if (event is FilterUpdated) {
      yield* _mapFilterUpdatedToState(event);
    } else if (event is TasksUpdated) {
      yield* _mapTasksUpdatedToState(event);
    } else if (event is SearchTasks) {
      yield* _mapSearchTasksToState(event.searchTerm);
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
          (tasksBloc.state as TasksLoadSuccess).tasks,
          event.filter,
          (tasksBloc.state as TasksLoadSuccess).user);
    }
  }

  Stream<FilteredTasksState> _mapSearchTasksToState(String event) async* {
    final users = await this.tasksRepository.getUserInfo();
    List<Task> tasks = (tasksBloc.state as TasksLoadSuccess).tasks;
    final listTask = await this.tasksRepository.searchTasks(event.trim());

    // List<Task> listTask = tasks
    //     .where((task) =>
    //         event.trim().toLowerCase().contains(task.title.toLowerCase()))
    //     .toList();
    //call api to search list of task
    //List<Task> listTask = await this.tasksRepository.searchTasks(event.trim());
    print(listTask);
    if (event.length > 0) {
      yield FilteredTasksLoadSuccess(listTask.map(Task.fromEntity).toList(),
          tasks, VisibilityFilter.all, User.fromEntity(users));
    } else {
      yield FilteredTasksLoadSuccess(
          _mapTasksToFilteredTasks(
            (tasksBloc.state as TasksLoadSuccess).tasks,
            VisibilityFilter.all,
          ),
          tasks,
          VisibilityFilter.all,
          User.fromEntity(users));
    }
  }

  Stream<FilteredTasksState> _mapTasksUpdatedToState(
    TasksUpdated event,
  ) async* {
    List<Task> tasks = (tasksBloc.state as TasksLoadSuccess).tasks;
    final visibilityFilter = state is FilteredTasksLoadSuccess
        ? (state as FilteredTasksLoadSuccess).activeFilter
        : VisibilityFilter.all;
    final users = await this.tasksRepository.getUserInfo();
    yield FilteredTasksLoadSuccess(
        _mapTasksToFilteredTasks(
          (tasksBloc.state as TasksLoadSuccess).tasks,
          visibilityFilter,
        ),
        tasks,
        visibilityFilter,
        User.fromEntity(users));
  }

  List<Task> _mapTasksToFilteredTasks(
      List<Task> tasks, VisibilityFilter filter) {
    return tasks.where((task) {
      if (filter == VisibilityFilter.all) {
        return true;
      } else if (filter == VisibilityFilter.active) {
        return !task.complete;
      } else if (filter == VisibilityFilter.favourite) {
        return task.favourite;
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
