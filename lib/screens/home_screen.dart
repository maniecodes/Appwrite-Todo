import 'package:appwrite_project/widgets/filter_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/widgets.dart';
import '../screens/screens.dart';
import '../utils/utils.dart';
import '../blocs/blocs.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilteredTasksBloc, FilteredTasksState>(
        builder: (context, state) {
      if (state is FilteredTasksLoadInProgress) {
        return Scaffold(
          appBar: AppBar(
            title: Text(FlutterBlocLocalizations.of(context).appTitle),
          ),
          body: Center(child: CircularProgressIndicator()),
        );
      } else if (state is FilteredTasksLoadSuccess) {
        final filteredTasks = state.filteredTasks;
        final user = state.user;
        final tasks = state.allTasks;

        return Scaffold(
          // backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(FlutterBlocLocalizations.of(context).appTitle),
            actions: [
              FilterButton(visible: true),
            ],
          ),

          drawer: AppDrawer(tasks: tasks, user: user),
          body: FilteredTasks(tasks: filteredTasks),
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
        return Scaffold(
          appBar: AppBar(
            title: Text(FlutterBlocLocalizations.of(context).appTitle),
          ),
          body: Center(child: CircularProgressIndicator()),
        );
      }
    });
  }
}
