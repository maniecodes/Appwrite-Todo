part of 'drawer_bloc.dart';

abstract class DrawerState extends Equatable {
  const DrawerState();

  @override
  List<Object> get props => [];
}

class DrawerLoadInProgress extends DrawerState {}

class DrawerLoadSuccess extends DrawerState {
  final int numFavourite;
  final int numPlanned;
  final int numMyDay;
  final int numTasks;
  //Add user after creating User model

  const DrawerLoadSuccess(
      this.numFavourite, this.numPlanned, this.numMyDay, this.numTasks);

  @override
  List<Object> get props => [numFavourite, numPlanned, numMyDay, numTasks];

  @override
  String toString() {
    return 'DrawerLoadSuccess {numFavourite: $numFavourite, numPlanned: $numPlanned, numMyDay: $numMyDay, numTasks: $numTasks}';
  }
}
