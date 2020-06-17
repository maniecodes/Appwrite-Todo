import 'package:flutter/material.dart';

import '../resources/repository.dart';
import '../models/models.dart';

/// A class that glues together our local file storage and web client. It has a
/// clear responsibility: Load Todos and Persist todos.
class TasksRepositoryFlutter implements TaskRepository {
  final FileStorage fileStorage;
  final WebClient webClient;

  const TasksRepositoryFlutter({
    @required this.fileStorage,
    this.webClient = const WebClient(),
  });

  /// Loads tasks first from File storage. If they don't exist or encounter an
  /// error, it attempts to load the Todos from a Web Client.
  @override
  Future<List<TaskEntity>> loadTasks() async {
    try {
      return await fileStorage.loadTasks();
    } catch (e) {
      final tasks = await webClient.fetchTasks();
      fileStorage.saveTasks(tasks);
      return tasks;
    }
  }

  // Persists tasks to local disk and the web
  @override
  Future saveTasksToLocal(TaskEntity task) async {
    final tasks = await fileStorage.loadTasks();
    return Future.wait<dynamic>([fileStorage.saveTasks(tasks..add(task))]);
  }

  @override
  Future saveTasksToAppwrite(TaskEntity task) async {
    return Future.wait<dynamic>([webClient.postTasks(task)]);
  }

  @override
  Future deleteTasksFromAppwrite(String taskId) async {
    print('task repository delete $taskId');
    return Future.wait<dynamic>([webClient.deleteTasks(taskId)]);
  }

  @override
  Future updateTasksOnAppwrite(String taskId, TaskEntity task) async {
    return Future.wait<dynamic>([webClient.updateTasks(taskId, task)]);
  }
}
