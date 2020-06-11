import 'dart:async';

import 'package:appwrite_project/blocs/tasks/tasks_bloc.dart';
import 'package:appwrite_project/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'drawer_event.dart';
part 'drawer_state.dart';

class DrawerBloc extends Bloc<DrawerEvent, DrawerState> {
  final TasksBloc tasksBloc;
  // final DrawerTab drawerTab;
  StreamSubscription tasksSubscription;

  DrawerBloc({@required this.tasksBloc}) {
    tasksSubscription = tasksBloc.listen((state) {
      if (state is TasksLoadSuccess) {
        add(DrawerUpdated(state.tasks));
      }
    });
  }

  @override
  get initialState => DrawerLoadInProgress();

  @override
  Stream<DrawerState> mapEventToState(DrawerEvent event) async* {
    if (event is DrawerUpdated) {
      // int numFavourite =
      //     event.tasks.where((task) => !task.favourite).toList().length;
      // int numTasks = event.tasks.length;
      int numFavourite = 15;
      int numTasks = 10;
      int numPlanned = 23;
      int numMyDay = 5;
      yield DrawerLoadSuccess(numFavourite, numPlanned, numMyDay, numTasks);
    }
  }

  @override
  Future<void> close() {
    tasksSubscription.cancel();
    return super.close();
  }
}
