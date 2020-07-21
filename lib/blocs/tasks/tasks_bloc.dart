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
      yield TasksLoadSuccess(
          tasks.map(Task.fromEntity).toList(), User.fromEntity(users));
    } catch (_) {
      yield TasksLoadFailure();
    }
  }

  Stream<TasksState> _mapTaskAddedToState(TaskAdded event) async* {
    if (state is TasksLoadSuccess) {
      await _saveTasksToAppwrite(event.task);
      final List<Task> updatedTasks =
          List.from((state as TasksLoadSuccess).tasks)..add(event.task);
      final users = await this.tasksRepository.getUserInfo();
      yield TasksLoadSuccess(updatedTasks, User.fromEntity(users));
    }
  }

  Stream<TasksState> _mapTaskUpdatedToState(TaskUpdated event) async* {
    if (state is TasksLoadSuccess) {
      final users = await this.tasksRepository.getUserInfo();
      final List<Task> updatedTasks =
          (state as TasksLoadSuccess).tasks.map((task) {
        return task.id == event.task.id ? event.task : task;
      }).toList();
      yield TasksLoadSuccess(updatedTasks, User.fromEntity(users));
      _updateTasksOnAppwrite(event.task.id, event.task);
    }
  }

  Stream<TasksState> _mapTaskDeletedToState(TaskDeleted event) async* {
    if (state is TasksLoadSuccess) {
      final updatedTasks = (state as TasksLoadSuccess)
          .tasks
          .where((task) => task.id != event.task.id)
          .toList();
      final users = await this.tasksRepository.getUserInfo();
      yield TasksLoadSuccess(updatedTasks, User.fromEntity(users));
      _deleteTasksFromAppwrite(event.task.id);
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
