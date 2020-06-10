import 'package:equatable/equatable.dart';

abstract class TasksEvent extends Equatable {
  const TasksEvent();

  @override
  List<Object> get props => [];
}

// Task loaded
class TasksLoaded extends TasksEvent {}

// Task added
class TasksAdded extends TasksEvent {}

// Task Updated

// Task Deleted

// Task Completed

// Task Toggle

// Task Favorite
