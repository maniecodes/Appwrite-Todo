import 'package:flutter/material.dart';
import '../resources/repository.dart';
import '../models/models.dart';

class TasksRepositoryFlutter implements TaskRepository {
  final WebClient webClient;

  const TasksRepositoryFlutter({@required this.webClient})
      : assert(webClient != null);

  @override
  Future<List<TaskEntity>> loadTasks() async {
    String userId = await getCurrentUser();
    try {
      //return await fileStorage.loadTasks(userId);

      return await webClient.fetchTasks(userId);
    } catch (e) {
      final tasks = await webClient.fetchTasks(userId);
      // fileStorage.saveTasks(tasks);
      return tasks;
    }
  }

  @override
  Future<List<TaskEntity>> searchTasks(String search) async {
    try {
      return await webClient.searchTasks(search);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<UserEntity> getUserInfo() async {
    // Get current logged in user ID
    String userId = await getCurrentUser();

    Map<String, dynamic> json = {};
    try {
      return await webClient.fetchUserInfo(userId);
    } catch (e) {
      print(e.toString());
      //TODO:: display error instead
      return UserEntity.fromJson(json);
    }
  }

  @override
  Future getCurrentUser() async {
    final userId = await webClient.getCurrentUser();
    return userId;
  }

  // Persists tasks to local disk and the web
  @override
  Future saveTasksToLocal(TaskEntity task) async {
    // final tasks = await fileStorage.loadTasks(getCurrentUser());
    // return Future.wait<dynamic>([fileStorage.saveTasks(tasks..add(task))]);
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
