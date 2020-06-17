import '../models/models.dart';

/// A data layer class works with reactive data sources, such as Firebase. This
/// class emits a Stream of TaskEntities. The data layer of the app.
///
/// How and where it stores the entities should defined in a concrete
/// implementation, such as firebase_repository_flutter.
///
/// The domain layer should depend on this abstract class, and each app can
/// inject the correct implementation depending on the environment
abstract class ReactiveTasksRepository {
  Future<void> addNewTask(TaskEntity task);

  Future<void> deleteTask(List<String> idList);

  Stream<List<TaskEntity>> tasks();

  Future<void> updateTask(TaskEntity task);
}
