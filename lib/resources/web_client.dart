import 'package:appwrite_project/models/models.dart';

class WebClient {
  final Duration delay;

  const WebClient({this.delay = const Duration(microseconds: 3000)});

  Future<List<TaskEntity>> fetchTasks() async {
    print('fetching tasks');
    return Future.delayed(
        delay,
        () => [
              TaskEntity(true, true, '1', 'Need to go on Vacation', 'Task'),
              TaskEntity(false, true, '2', 'Global news', 'News'),
              TaskEntity(true, false, '4', 'Flycash', 'Testing Flycash'),
              TaskEntity(false, false, '5', 'Appwrite', 'description'),
              TaskEntity(false, true, '6', 'Sample', 'Test'),
            ]);
  }

  Future<bool> postTasks(List<TaskEntity> tasks) async {
    return Future.value(true);
  }
}
