import 'package:equatable/equatable.dart';
import '../utils/utils.dart';
import '../models/models.dart';

class Task extends Equatable {
  final bool complete;
  final bool favourite;
  final String id;
  final String title;
  final String description;
  final String uid;

  Task(
    this.title, {
    this.complete = false,
    this.favourite = false,
    String description = '',
    String uid,
    String id,
  })  : this.description = description ?? '',
        this.uid = uid ?? '',
        this.id = id ?? Uuid().generateV4();

  Task copyWith(
      {bool complete,
      bool favourite,
      String id,
      String title,
      String description,
      String uid}) {
    return Task(title ?? this.title,
        complete: complete ?? this.complete,
        favourite: favourite ?? this.favourite,
        id: id ?? this.id,
        description: description ?? this.description,
        uid: uid ?? this.uid);
  }

  @override
  List<Object> get props => [complete, favourite, id, title, description, uid];

  @override
  String toString() {
    return 'Task { complete: $complete, favourite: $favourite, title: $title, description: $description, uid: $uid, id: $id}';
  }

  TaskEntity toEntity() {
    return TaskEntity(complete, favourite, id, title, description, uid);
  }

  static Task fromEntity(TaskEntity entity) {
    return Task(
      entity.title,
      complete: entity.complete ?? false,
      favourite: entity.favourite ?? false,
      description: entity.description,
      uid: entity.uid,
      id: entity.id ?? Uuid().generateV4(),
    );
  }
}
