import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/blocs.dart';
import '../utils/utils.dart';
import '../widgets/widgets.dart';

class FilteredTasks extends StatelessWidget {
  FilteredTasks({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilteredTasksBloc, FilteredTasksState>(
      builder: (context, state) {
        if (state is FilteredTasksLoadInProgress) {
          return CircularProgressIndicator();
        } else if (state is FilteredTasksLoadSuccess) {
          final tasks = state.filteredTasks;
          return ListView.builder(
            key: TasksKeys.taskList,
            itemCount: tasks.length,
            itemBuilder: (BuildContext context, int index) {
              final task = tasks[index];
              return TaskItem(
                task: task,
                onDismissed: (direction) {
                  BlocProvider.of<TasksBloc>(context).add(TaskDeleted(task));
                  Scaffold.of(context).showSnackBar(DeleteTaskSnackBar(
                      task: task,
                      onUndo: () => BlocProvider.of<TasksBloc>(context)
                          .add(TaskAdded(task))));
                },
                onTap: () {
                  print('got to tap');
                },
                onCheckboxChanged: (_) {
                  BlocProvider.of<TasksBloc>(context).add(
                    TaskUpdated(task.copyWith(complete: !task.complete)),
                  );
                  print(!task.complete);
                },
              );
            },
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
