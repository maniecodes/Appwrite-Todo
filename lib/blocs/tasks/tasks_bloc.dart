import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../models/models.dart';
import '../../resources/repository.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  final TasksRepositoryFlutter tasksRepository;
  final UserRepositoryFlutter userRepository;

  TasksBloc({@required this.tasksRepository, this.userRepository});

  @override
  TasksState get initialState => TasksLoadInProgress();

  @override
  Stream<TasksState> mapEventToState(TasksEvent event) async* {
    if (event is TasksLoaded) {
      print('task loaded');
      yield* _mapTasksLoadedToState();
    } else if (event is TaskAdded) {
      yield* _mapTaskAddedToState(event);
    } else if (event is TaskUpdated) {
      print('task updated');
      yield* _mapTaskUpdatedToState(event);
    } else if (event is TaskDeleted) {
      yield* _mapTaskDeletedToState(event);
    }
  }

  Stream<TasksState> _mapTasksLoadedToState() async* {
    print('loading task state');
    try {
      final users = await this.tasksRepository.getUserInfo();
      final tasks = await this.tasksRepository.loadTasks();
      print(tasks);
      print('my task above');
      //
      // print(users);
      yield TasksLoadSuccess(
          tasks.map(Task.fromEntity).toList(), User.fromEntity(users));
    } catch (_) {
      print('error');
      yield TasksLoadFailure();
    }
  }

  Stream<TasksState> _mapTaskAddedToState(TaskAdded event) async* {
    if (state is TasksLoadSuccess) {
      await _saveTasksToAppwrite(event.task);
      final tasks = await this.tasksRepository.loadTasks();
      final users = await this.tasksRepository.getUserInfo();

      yield TasksLoadSuccess(
          tasks.map(Task.fromEntity).toList(), User.fromEntity(users));
    }
  }

  Stream<TasksState> _mapTaskUpdatedToState(TaskUpdated event) async* {
    if (state is TasksLoadSuccess) {
      await _updateTasksOnAppwrite(event.task.id, event.task);
      final tasks = await this.tasksRepository.loadTasks();
      final users = await this.tasksRepository.getUserInfo();
      yield TasksLoadSuccess(
          tasks.map(Task.fromEntity).toList(), User.fromEntity(users));
    }
  }

  Stream<TasksState> _mapTaskDeletedToState(TaskDeleted event) async* {
    if (state is TasksLoadSuccess) {
      await _deleteTasksFromAppwrite(event.task.id);
      final tasks = await this.tasksRepository.loadTasks();
      final users = await this.tasksRepository.getUserInfo();
      yield TasksLoadSuccess(
          tasks.map(Task.fromEntity).toList(), User.fromEntity(users));
    }
  }

  Future _saveTasksToAppwrite(Task tasks) {
    return tasksRepository.saveTasksToAppwrite(tasks.toEntity());
  }

  Future _deleteTasksFromAppwrite(String taskId) {
    print('delete taks from appwrite: $taskId');
    return tasksRepository.deleteTasksFromAppwrite(taskId);
  }

  Future _updateTasksOnAppwrite(String taskId, Task tasks) {
    return tasksRepository.updateTasksOnAppwrite(taskId, tasks.toEntity());
  }
}
