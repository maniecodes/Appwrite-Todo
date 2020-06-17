import 'dart:async';

import 'package:appwrite_project/blocs/tasks/tasks_bloc.dart';
import 'package:appwrite_project/models/models.dart';
import 'package:appwrite_project/models/user.dart';
import 'package:appwrite_project/resources/repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'drawer_event.dart';
part 'drawer_state.dart';

class DrawerBloc extends Bloc<DrawerEvent, DrawerState> {
  final TasksBloc tasksBloc;
  final UserRepository userRepository;

  // final DrawerTab drawerTab;
  StreamSubscription tasksSubscription;

  DrawerBloc({@required this.tasksBloc, this.userRepository})
      : assert(tasksBloc != null),
        assert(userRepository != null) {
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
      try {
        final users = await userRepository.getUserInfo();
        final email = users.email;
        final name = users.name;
        final phone = users.phone;

        // int numFavourite =
        //     event.tasks.where((task) => !task.favourite).toList().length;
        // int numTasks = event.tasks.length;
        int numFavourite = 15;
        int numTasks = 10;
        int numPlanned = 23;
        int numMyDay = 5;
        yield DrawerLoadSuccess(
            numFavourite, numPlanned, numMyDay, numTasks, email, name, phone);
      } catch (e) {
        print(e.toString());
      }
    }
  }

  @override
  Future<void> close() {
    tasksSubscription.cancel();
    return super.close();
  }
}
