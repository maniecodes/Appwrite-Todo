import 'package:appwrite_project/blocs/tasks/tasks_bloc.dart';
import 'package:appwrite_project/localization/task_localization.dart';
import 'package:appwrite_project/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskDetailsScreen extends StatelessWidget {
  final String id;

  TaskDetailsScreen({Key key, @required this.id})
      : super(key: key ?? TasksKeys.taskDetailsScreen);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        final task = (state as TasksLoadSuccess)
            .tasks
            .firstWhere((task) => task.id == id, orElse: () => null);
        final localizations = TaskLocalizations.of(context);
        return Scaffold(
            appBar: AppBar(
              title: Text(localizations.taskDetails),
              actions: <Widget>[
                IconButton(
                    tooltip: localizations.deleteTask,
                    key: TasksKeys.deleteTaskButton,
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      BlocProvider.of<TasksBloc>(context)
                          .add(TaskDeleted(task));
                      Navigator.pop(context, task);
                    })
              ],
            ),
            body: task == null
                ? Container(key: TasksKeys.emptyDetailsContainer)
                : Padding(
                    padding: EdgeInsets.all(15.0),
                    child: ListView(
                      children: <Widget>[],
                    ),
                  ));
      },
    );
  }
}
