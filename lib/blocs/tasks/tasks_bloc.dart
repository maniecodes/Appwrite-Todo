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
    print('loading state');
    try {
      final tasks = await this.tasksRepository.loadTasks();
      yield TasksLoadSuccess(tasks.map(Task.fromEntity).toList());
    } catch (_) {
      yield TasksLoadFailure();
    }
  }

  Stream<TasksState> _mapTaskAddedToState(TaskAdded event) async* {
    print('add task to state');
    if (state is TasksLoadSuccess) {
      //final tasks = await this.tasksRepository.loadTasks();
      final List<Task> updatedTaskss =
          List.from((state as TasksLoadSuccess).tasks)..add(event.task);
      yield TasksLoadSuccess(updatedTaskss);
      _saveTasksToLocal(event.task);
      _saveTasksToAppwrite(event.task);
    }
  }

  Stream<TasksState> _mapTaskUpdatedToState(TaskUpdated event) async* {
    if (state is TasksLoadSuccess) {
      final List<Task> updatedTasks =
          (state as TasksLoadSuccess).tasks.map((task) {
        return task.id == event.task.id ? event.task : task;
      }).toList();
      yield TasksLoadSuccess(updatedTasks);
      _saveTasksToLocal(event.task);
    }
  }

  Stream<TasksState> _mapTaskDeletedToState(TaskDeleted event) async* {
    if (state is TasksLoadSuccess) {
      final updatedTasks = (state as TasksLoadSuccess)
          .tasks
          .where((task) => task.id != event.task.id)
          .toList();
      yield TasksLoadSuccess(updatedTasks);
      _saveTasksToLocal(event.task);
      print('map task deleted');
      print(event.task.id);
      _deleteTasksFromAppwrite(event.task.id);
    }
  }

  Future _saveTasksToLocal(Task tasks) {
    return tasksRepository.saveTasksToLocal(tasks.toEntity());
  }

  Future _saveTasksToAppwrite(Task tasks) {
    return tasksRepository.saveTasksToAppwrite(tasks.toEntity());
  }

  Future _deleteTasksFromAppwrite(String taskId) {
    print('delete taks from appwrite: $taskId');
    return tasksRepository.deleteTasksFromAppwrite(taskId);
  }
}
