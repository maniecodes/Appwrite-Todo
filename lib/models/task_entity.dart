class TaskEntity {
  final bool complete;
  final bool favourite;
  final String id;
  final String title;
  final String description;
  final String createdDateTime;
  final String dueDateTime;
  final String uid;

  TaskEntity(this.complete, this.favourite, this.id, this.title,
      this.description, this.createdDateTime, this.dueDateTime, this.uid);

  @override
  int get hashCode =>
      complete.hashCode ^
      favourite.hashCode ^
      title.hashCode ^
      description.hashCode ^
      createdDateTime.hashCode ^
      dueDateTime.hashCode ^
      uid.hashCode ^
      id.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskEntity &&
          runtimeType == other.runtimeType &&
          complete == other.complete &&
          favourite == other.favourite &&
          title == other.title &&
          description == other.description &&
          createdDateTime == other.createdDateTime &&
          dueDateTime == other.dueDateTime &&
          uid == other.uid &&
          id == other.id;

  Map<String, Object> toJson() {
    return {
      'complete': complete,
      'favourite': favourite,
      'title': title,
      'description': description,
      'createdDateTime': createdDateTime,
      'dueDateTime': dueDateTime,
      'uid': uid,
      'id': id,
    };
  }

  @override
  String toString() {
    return 'TaskEntity{complete: $complete, favourite: $favourite, title: $title, description: $description, createdDateTime: $createdDateTime, dueDateTime: $dueDateTime, uid: $uid, id: $id}';
  }

  static TaskEntity fromJson(Map<String, Object> json) {
    return TaskEntity(
        json['complete'] as bool,
        json['favourite'] as bool,
        json['id'] as String,
        json['title'] as String,
        json['description'] as String,
        json['createdDateTime'] as String,
        json['dueDateTime'] as String,
        json['uid'] as String);
  }
}
