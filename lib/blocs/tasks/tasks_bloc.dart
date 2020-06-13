import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../models/models.dart';
import '../../resources/repository.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  final TasksRepositoryFlutter tasksRepository;

  TasksBloc({@required this.tasksRepository});

  @override
  TasksState get initialState => TasksLoadInProgress();

  @override
  Stream<TasksState> mapEventToState(TasksEvent event) async* {
    if (event is TasksLoaded) {
      yield* _mapTasksLoadedToState();
    } else if (event is TaskAdded) {
      yield* _mapTaskAddedToState(event);
    } else if (event is TaskUpdated) {
      yield* _mapTaskUpdatedToState(event);
    } else if (event is TaskDeleted) {
      yield* _mapTaskDeletedToState(event);
    }
  }

  Stream<TasksState> _mapTasksLoadedToState() async* {
    try {
      final tasks = await this.tasksRepository.loadTasks();
      yield TasksLoadSuccess(tasks.map(Task.fromEntity).toList());
    } catch (_) {
      yield TasksLoadFailure();
    }
  }

  Stream<TasksState> _mapTaskAddedToState(TaskAdded event) async* {
    if (state is TasksLoadSuccess) {
      final List<Task> updatedTasks =
          List.from((state as TasksLoadSuccess).tasks)..add(event.task);
      yield TasksLoadSuccess(updatedTasks);
      _saveTasks(updatedTasks);
    }
  }

  Stream<TasksState> _mapTaskUpdatedToState(TaskUpdated event) async* {
    if (state is TasksLoadSuccess) {
      final List<Task> updatedTasks =
          (state as TasksLoadSuccess).tasks.map((task) {
        return task.id == event.task.id ? event.task : task;
      }).toList();
      yield TasksLoadSuccess(updatedTasks);
      _saveTasks(updatedTasks);
    }
  }

  Stream<TasksState> _mapTaskDeletedToState(TaskDeleted event) async* {
    if (state is TasksLoadSuccess) {
      final updatedTasks = (state as TasksLoadSuccess)
          .tasks
          .where((task) => task.id != event.task.id)
          .toList();
      yield TasksLoadSuccess(updatedTasks);
      _saveTasks(updatedTasks);
    }
  }

  Future _saveTasks(List<Task> tasks) {
    return tasksRepository.saveTasks(
      tasks.map((task) => task.toEntity()).toList(),
    );
  }
}
