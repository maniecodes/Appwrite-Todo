import 'package:appwrite_project/utils/utils.dart';
import 'package:flutter/material.dart';

import 'package:appwrite_project/models/task.dart';

typedef OnSaveCallback = Function(String title, String description);

class AddEditTaskScreen extends StatefulWidget {
  final bool isEditing;
  final OnSaveCallback onSave;
  final Task task;

  AddEditTaskScreen(
      {Key key, @required this.onSave, @required this.isEditing, this.task})
      : super(key: key ?? TasksKeys.addTaskScreen);

  @override
  _AddEditTaskScreenState createState() => _AddEditTaskScreenState();
}

class _AddEditTaskScreenState extends State<AddEditTaskScreen> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _title;
  String _description;
  bool get isEditing => widget.isEditing;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
