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

  Future _saveTasks(List<Task> tasks) {
    return tasksRepository.saveTasks(
      tasks.map((task) => task.toEntity()).toList(),
    );
  }
}
