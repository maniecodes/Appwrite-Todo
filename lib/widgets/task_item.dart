import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart';
import 'package:time_formatter/time_formatter.dart';
import '../utils/utils.dart';
import '../models/models.dart';

class TaskItem extends StatelessWidget {
  final DismissDirectionCallback onDismissed;
  final GestureDragCancelCallback onTap;
  final ValueChanged<bool> onCheckboxChanged;
  final Function onFavouriteSelected;
  final Task task;

  TaskItem(
      {Key key,
      @required this.onDismissed,
      @required this.onTap,
      @required this.onCheckboxChanged,
      @required this.onFavouriteSelected,
      @required this.task})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var parsedDate =
        DateTime.parse(task.createdDateTime).millisecondsSinceEpoch;
    String formatted = formatTime(parsedDate);

    return Dismissible(
      key: TasksKeys.taskItem(task.id),
      onDismissed: onDismissed,
      child: InkWell(
        onTap: onTap,
        child: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Checkbox(
                        key: TasksKeys.taskItemCheckbox(task.id),
                        value: task.complete,
                        onChanged: onCheckboxChanged,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(task.title,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0,
                                          color: Colors.black)),
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        task.description,
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.black54),
                                      ),
                                      Text(
                                        ' - ',
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.black54),
                                      ),
                                      Icon(
                                        Icons.calendar_today,
                                        color: Colors.black54,
                                        size: 10.0,
                                      ),
                                      SizedBox(
                                        width: 2,
                                      ),
                                      Text(
                                        formatted,
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.black54),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  InkWell(
                                    onTap: onFavouriteSelected,
                                    child: Container(
                                      child: !task.favourite
                                          ? Icon(
                                              Icons.favorite_border,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
