import 'package:appwrite_project/models/models.dart';
import 'package:equatable/equatable.dart';
import '../utils/utils.dart';

class Task extends Equatable {
  final bool complete;
  final bool favourite;
  final String id;
  final String title;
  final String description;

  Task(
    this.title, {
    this.complete = false,
    this.favourite = false,
    String description = '',
    String id,
  })  : this.description = description ?? '',
        this.id = id ?? Uuid().generateV4();

  Task copyWith(
      {bool complete,
      bool favourite,
      String id,
      String title,
      String description}) {
    return Task(title ?? this.title,
        complete: complete ?? this.complete,
        favourite: favourite ?? this.favourite,
        id: id ?? this.id,
        description: description ?? this.description);
  }

  @override
  List<Object> get props => [complete, favourite, id, title, description];

  @override
  String toString() {
    return 'Task { complete: $complete, favourite: $favourite, title: $title, description: $description, id: $id}';
  }

  TaskEntity toEntity() {
    return TaskEntity(complete, favourite, id, title, description);
  }

  static Task fromEntity(TaskEntity entity) {
    return Task(
      entity.title,
      complete: entity.complete ?? false,
      favourite: entity.favourite ?? false,
      description: entity.description,
      id: entity.id ?? Uuid().generateV4(),
    );
  }
}
