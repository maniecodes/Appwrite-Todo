import 'dart:convert';
import 'dart:io';

import '../models/models.dart';

/// Loads and saves a List of Tasks using a text file stored on the device.
///
/// Note: This class has no direct dependencies on any Flutter dependencies.
/// Instead, the `getDirectory` method should be injected. This allows for
/// testing.

class FileStorage {
  final String tag;
  final Future<Directory> Function() getDirectory;

  const FileStorage(this.tag, this.getDirectory);

  Future<List<TaskEntity>> loadTasks(userId) async {
    final file = await _getLocalFile();
    final string = await file.readAsString();
    final json = JsonDecoder().convert(string);
    final tasks = (json['tasks'])
        .map<TaskEntity>((task) => TaskEntity.fromJson(task))
        .where((task) => task.uid == userId)
        .toList();

    return tasks;
  }

  Future<File> saveTasks(List<TaskEntity> tasks) async {
    final file = await _getLocalFile();

    return file.writeAsString(JsonEncoder().convert({
      'tasks': tasks.map((task) => task.toJson()).toList(),
    }));
  }

  Future<File> _getLocalFile() async {
    final dir = await getDirectory();
    return File('${dir.path}/TaskStorage__$tag.json');
  }

  Future<FileSystemEntity> clean() async {
    final file = await _getLocalFile();
    return file.delete();
  }
}
