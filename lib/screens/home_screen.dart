import 'package:appwrite_project/blocs/filtered_tasks/filtered_tasks_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/widgets.dart';
import '../screens/screens.dart';
import '../utils/utils.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilteredTasksBloc, FilteredTasksState>(
        builder: (context, state) {
      if (state is FilteredTasksLoadInProgress) {
        return CircularProgressIndicator();
      } else if (state is FilteredTasksLoadSuccess) {
        final tasks = state.filteredTasks;
        final user = state.user;

        return Scaffold(
          // backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(FlutterBlocLocalizations.of(context).appTitle),
          ),

          drawer: AppDrawer(tasks: tasks, user: user),
          body: FilteredTasks(tasks: tasks),
          floatingActionButton: FloatingActionButton(
            key: TasksKeys.addTaskFab,
            onPressed: () {
              Navigator.pushNamed(context, TaskRoutes.addTask);
            },
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        );
      } else {
        return CircularProgressIndicator();
      }
    });
  }
}
