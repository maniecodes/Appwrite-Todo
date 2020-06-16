part of 'drawer_bloc.dart';

abstract class DrawerEvent extends Equatable {
  const DrawerEvent();
}

class DrawerUpdated extends DrawerEvent {
  final List<Task> tasks;

  // final DrawerTab tab;

  const DrawerUpdated(
    this.tasks,
  );

  @override
  List<Object> get props => [tasks];

  @override
  String toString() => 'UpdateDrawer { tasks: $tasks}';
}
