class TaskEntity {
  final bool complete;
  final bool favourite;
  final String id;
  final String title;
  final String description;

  TaskEntity(
      this.complete, this.favourite, this.id, this.title, this.description);

  @override
  int get hashCode =>
      complete.hashCode ^
      favourite.hashCode ^
      title.hashCode ^
      description.hashCode ^
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
          id == other.id;

  Map<String, Object> toJson() {
    return {
      'complete': complete,
      'favourite': favourite,
      'title': title,
      'description': description,
      'id': id,
    };
  }

  @override
  String toString() {
    return 'TaskEntity{complete: $complete, favourite: $favourite, title: $title, description: $description, id: $id}';
  }

  static TaskEntity fromJson(Map<String, Object> json) {
    return TaskEntity(
        json['complete'] as bool,
        json['favourite'] as bool,
        json['id'] as String,
        json['title'] as String,
        json['description'] as String);
  }
}
