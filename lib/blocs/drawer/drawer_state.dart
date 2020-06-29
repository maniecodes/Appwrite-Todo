part of 'drawer_bloc.dart';

abstract class DrawerState extends Equatable {
  const DrawerState();

  @override
  List<Object> get props => [];
}

class DrawerLoadInProgress extends DrawerState {}

class DrawerLoadSuccess extends DrawerState {
  final int numFavourite;
  final int numComplete;
  final int numPlanned;
  final int numMyDay;
  final int numTasks;
  final String email;
  final String name;
  final String phone;

  const DrawerLoadSuccess(this.numFavourite, this.numComplete, this.numPlanned,
      this.numMyDay, this.numTasks, this.email, this.name, this.phone);

  @override
  List<Object> get props => [
        numFavourite,
        numComplete,
        numPlanned,
        numMyDay,
        numTasks,
        email,
        name,
        phone
      ];

  @override
  String toString() {
    return 'DrawerLoadSuccess {numFavourite: $numFavourite, numComplete: $numComplete, numPlanned: $numPlanned, numMyDay: $numMyDay, numTasks: $numTasks, "}';
  }
}
