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
  final String createdDateTime;
  final String dueDateTime;

  Task(
    this.title, {
    this.complete = false,
    this.favourite = false,
    String description = '',
    String createdDateTime,
    String dueDateTime,
    String uid,
    String id,
  })  : this.description = description ?? '',
        this.createdDateTime =
            createdDateTime ?? DateTime.now().toLocal().toString(),
        this.dueDateTime = dueDateTime ?? '',
        this.uid = uid ?? '',
        this.id = id ?? Uuid().generateV4();

  Task copyWith(
      {String title,
      bool complete,
      bool favourite,
      String description,
      String createdDateTime,
      String dueDateTime,
      String uid,
      String id}) {
    return Task(title ?? this.title,
        complete: complete ?? this.complete,
        favourite: favourite ?? this.favourite,
        description: description ?? this.description,
        createdDateTime: createdDateTime ?? this.createdDateTime,
        dueDateTime: dueDateTime ?? this.dueDateTime,
        uid: uid ?? this.uid,
        id: id ?? this.id);
  }

  @override
  List<Object> get props => [
        title,
        complete,
        favourite,
        description,
        createdDateTime,
        dueDateTime,
        uid,
        id
      ];

  @override
  String toString() {
    return 'Task { complete: $complete, favourite: $favourite, title: $title, description: $description, createdDateTime: $createdDateTime, dueDateTime: $dueDateTime, uid: $uid, id: $id}';
  }

  TaskEntity toEntity() {
    return TaskEntity(complete, favourite, id, title, description,
        createdDateTime, dueDateTime, uid);
  }

  static Task fromEntity(TaskEntity entity) {
    return Task(
      entity.title,
      complete: entity.complete ?? false,
      favourite: entity.favourite ?? false,
      description: entity.description,
      createdDateTime:
          entity.createdDateTime ?? DateTime.now().toLocal().toString(),
      dueDateTime: entity.dueDateTime,
      uid: entity.uid,
      id: entity.id ?? Uuid().generateV4(),
    );
  }
}
