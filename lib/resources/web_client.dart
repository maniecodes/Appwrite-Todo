import 'package:appwrite_project/models/models.dart';

class WebClient {
  final Duration delay;

  const WebClient({this.delay = const Duration(microseconds: 3000)});

  Future<List<TaskEntity>> fetchTasks() async {
    return Future.delayed(
        delay,
        () => [
              TaskEntity(true, true, '1', 'Title 1', 'My description'),
              TaskEntity(false, true, '2', 'Title 1', 'My description'),
              TaskEntity(false, false, '3', 'Title 1', 'My description'),
              TaskEntity(true, false, '4', 'Title 1', 'My description'),
              TaskEntity(false, false, '5', 'Title 1', 'My description'),
              TaskEntity(false, true, '6', 'Title 1', 'My description'),
            ]);
  }

  Future<bool> postTasks(List<TaskEntity> tasks) async {
    return Future.value(true);
  }
}
