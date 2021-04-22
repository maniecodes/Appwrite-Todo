import 'dart:async';
import 'package:appwrite_project/resources/user_repository_flutter.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/blocs.dart';
import '../../models/models.dart';
import '../../resources/repository.dart';

part 'drawer_event.dart';
part 'drawer_state.dart';

class DrawerBloc extends Bloc<DrawerEvent, DrawerState> {
  final TasksBloc tasksBloc;
  final UserRepositoryFlutter userRepository;
  final TasksRepositoryFlutter tasksRepository;

  // final DrawerTab drawerTab;
  StreamSubscription tasksSubscription;

  DrawerBloc(
      {@required this.tasksBloc, this.userRepository, this.tasksRepository})
      : assert(tasksBloc != null),
        assert(userRepository != null),
        assert(tasksRepository != null), super(DrawerLoadInProgress()) {
    tasksSubscription = tasksBloc.stream.listen((state) {
      if (state is TasksLoadSuccess) {
        add(DrawerUpdated(state.tasks));
      }
    });
  }

  @override
  Stream<DrawerState> mapEventToState(DrawerEvent event) async* {
    if (event is DrawerUpdated) {
      try {
        //Think of how to load this information once the user login for better performance
        final users = await this.userRepository.getUserInfo();
        final tasks = await this.tasksRepository.loadTasks();
        final email = users.email;
        final name = users.name;
        final phone = users.phone;

        int numFavourite =
            tasks.where((task) => task.favourite).toList().length;
        int numTasks = tasks.length;
        int numComplete = tasks.where((task) => task.complete).toList().length;
        int numPlanned = 23;
        int numMyDay = 5;
        yield DrawerLoadSuccess(numFavourite, numComplete, numPlanned, numMyDay,
            numTasks, email, name, phone);
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
