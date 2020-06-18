import '../models/models.dart';

/// A class that Loads and Persists tasks. The data layer of the app.
///
/// How and where it stores the entities should defined in a concrete
/// implementation, such as tasks_repository_simple
///
/// The domain layer should depend on this abstract class, and each app can
/// inject the correct implementation depending on the environment.
abstract class TaskRepository {
  /// Loads tasks first from File storage. If they don't exist or encounter an
  /// error, it attempts to load the Todos from a Web Client.
  Future<List<TaskEntity>> loadTasks();

  Future saveTasksToLocal(TaskEntity tasks);

  Future saveTasksToAppwrite(TaskEntity tasks);

  Future deleteTasksFromAppwrite(String taskId);

  Future updateTasksOnAppwrite(String taskId, TaskEntity tasks);

  Future getCurrentUser();
}
