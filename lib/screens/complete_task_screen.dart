import 'package:appwrite_project/blocs/filtered_tasks/filtered_tasks_bloc.dart';
import 'package:appwrite_project/models/task.dart';
import 'package:appwrite_project/utils/utils.dart';
import 'package:appwrite_project/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompleteTaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilteredTasksBloc, FilteredTasksState>(
        builder: (context, state) {
      if (state is FilteredTasksLoadInProgress) {
        return CircularProgressIndicator();
      } else if (state is FilteredTasksLoadSuccess) {
        final user = state.user;
        final tasks = state.allTasks;
        List<Task> completedTasks =
            tasks.where((task) => task.complete).toList();

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(FlutterBlocLocalizations.of(context).appTitle),
          ),
          drawer: AppDrawer(tasks: tasks, user: user),
          body: ViewTask(tasks: completedTasks),
        );
      } else {
        return CircularProgressIndicator();
      }
    });
  }
}
