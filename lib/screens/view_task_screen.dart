
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/blocs.dart';
import '../utils/utils.dart';
import '../widgets/widgets.dart';

class ViewTaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('view task');
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
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(FlutterBlocLocalizations.of(context).appTitle),
          ),
          drawer: AppDrawer(tasks: tasks, user: user),
          body: ViewTask(tasks: filteredTasks),
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
