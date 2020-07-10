import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/blocs.dart';
import '../localization/task_localization.dart';
import '../screens/screens.dart';
import '../utils/utils.dart';

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
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: ListView(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: Checkbox(
                                      key: TasksKeys.detailsScreenCheckBox,
                                      value: task.complete,
                                      onChanged: (_) {
                                        BlocProvider.of<TasksBloc>(context).add(
                                            TaskUpdated(task.copyWith(
                                                complete: !task.complete)));
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Colors.grey.shade400,
                                          width: 1,
                                        ),
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                            color: Colors.grey.shade400,
                                            offset: Offset(1, 1),
                                            blurRadius: 5,
                                            spreadRadius: .8,
                                          )
                                        ],
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(task.title,
                                                    key: TasksKeys
                                                        .detailsTaskItemTitle,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15.0,
                                                        color: Colors.black)),
                                                Row(
                                                  children: <Widget>[
                                                    Text(
                                                      task.description,
                                                      key: TasksKeys
                                                          .detailsTaskItemDescription,
                                                      style: TextStyle(
                                                          fontSize: 12.0,
                                                          color:
                                                              Colors.black26),
                                                    ),
                                                    Text(
                                                      ' - ',
                                                      style: TextStyle(
                                                          fontSize: 12.0,
                                                          color:
                                                              Colors.black26),
                                                    ),
                                                    Icon(
                                                      Icons.calendar_today,
                                                      color: Colors.black26,
                                                      size: 10.0,
                                                    ),
                                                    Text(
                                                      ' Fri, Jun 12',
                                                      style: TextStyle(
                                                          fontSize: 12.0,
                                                          color:
                                                              Colors.black26),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: <Widget>[
                                                InkWell(
                                                  onTap: () {
                                                    BlocProvider.of<TasksBloc>(
                                                            context)
                                                        .add(TaskUpdated(
                                                            task.copyWith(
                                                                favourite: !task
                                                                    .favourite)));
                                                  },
                                                  child: Container(
                                                    child: !task.favourite
                                                        ? Icon(
                                                            Icons
                                                                .favorite_border,
                                                            color: Colors.blue,
                                                            size: 20.0,
                                                          )
                                                        : Icon(
                                                            Icons.favorite,
                                                            color: Colors.blue,
                                                            size: 20.0,
                                                          ),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          key: TasksKeys.editTaskFab,
                          onTap: task == null
                              ? null
                              : () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return AddEditTaskScreen(
                                      key: TasksKeys.editTaskScreen,
                                      onSave:
                                          (title, description, dueDateTime) {
                                        BlocProvider.of<TasksBloc>(context).add(
                                            TaskUpdated(task.copyWith(
                                                title: title,
                                                description: description,
                                                dueDateTime: dueDateTime)));
                                      },
                                      isEditing: true,
                                      task: task,
                                    );
                                  }));
                                },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: Colors.grey.shade500,
                                      offset: Offset(2, 2),
                                      blurRadius: 5,
                                      spreadRadius: 2)
                                ],
                                gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      HexColor('#223FA1'),
                                      HexColor('#223FA1'),
                                    ])),
                            child: Text('Edit',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                    color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                  ));
      },
    );
  }
}
