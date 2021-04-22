import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../localization/task_localization.dart';
import '../utils/utils.dart';
import '../models/models.dart';

typedef OnSaveCallback = Function(
    String title, String description, String dueDateTime);

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
  final format = DateFormat("dd-M-yyyy");

  String _title;
  String _description;
  String _dueDateTime;
  bool get isEditing => widget.isEditing;
  DateTime date = DateTime(1900);

  @override
  Widget build(BuildContext context) {
    final localizations = TaskLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? localizations.editTask : localizations.addTask),
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView(
                  children: <Widget>[
                    Center(
                      child: Text('Fill the form to add task'),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Colors.grey.shade400,
                              offset: Offset(1, 1),
                              blurRadius: 5,
                              spreadRadius: .5)
                        ],
                      ),
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.always, initialValue: isEditing ? widget.task.title : '',
                        key: TasksKeys.titleField,
                        style: TextStyle(
                            fontSize: 20.0, height: 2.0, color: Colors.black),
                        decoration: InputDecoration(
                          hintText: localizations.newTitleHint,
                          hintStyle:
                              TextStyle(fontSize: 20.0, color: Colors.grey),
                          border: InputBorder.none,
                          // fillColor: Color(0xfff3f3f4),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1.0)),
                        ),
                        autocorrect: false,
                        // validator: (val) {
                        //   return val.trim().isEmpty
                        //       ? localizations.emptyTaskError
                        //       : null;
                        // },
                        onSaved: (value) => _title = value,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Colors.grey.shade400,
                              offset: Offset(1, 1),
                              blurRadius: 5,
                              spreadRadius: .5)
                        ],
                      ),
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.always, initialValue: isEditing ? widget.task.description : '',
                        key: TasksKeys.titleField,
                        style: TextStyle(
                            fontSize: 20.0, height: 2.0, color: Colors.black),
                        maxLines: 5,
                        decoration: InputDecoration(
                          hintText: localizations.descriptionHint,
                          hintStyle:
                              TextStyle(fontSize: 20.0, color: Colors.grey),
                          border: InputBorder.none,
                          // fillColor: Color(0xfff3f3f4),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1.0)),
                        ),
                        autocorrect: false,
                        onSaved: (value) => _description = value,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Colors.grey.shade400,
                              offset: Offset(1, 1),
                              blurRadius: 5,
                              spreadRadius: .5)
                        ],
                      ),
                      child: DateTimeField(
                        initialValue: isEditing
                            ? DateTime.parse(widget.task.dueDateTime)
                            : null,
                        key: TasksKeys.dueDateField,
                        decoration: InputDecoration(
                          hintText: localizations.newDueDateHint,
                          hintStyle:
                              TextStyle(fontSize: 20.0, color: Colors.grey),
                          border: InputBorder.none,
                          // fillColor: Color(0xfff3f3f4),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1.0)),
                        ),
                        format: format,
                        onShowPicker: (context, currentValue) {
                          return showDatePicker(
                              context: context,
                              firstDate: DateTime(1900),
                              initialDate: currentValue ?? DateTime.now(),
                              lastDate: DateTime(2100));
                        },
                        onSaved: (value) => _dueDateTime = value.toString(),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
              InkWell(
                key: isEditing ? TasksKeys.saveTaskFab : TasksKeys.saveNewTask,
                onTap: () {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    widget.onSave(_title, _description, _dueDateTime);
                    Navigator.pop(context);
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
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
                  child: isEditing
                      ? Text('Update Task',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color: Colors.white))
                      : Text('Save',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
