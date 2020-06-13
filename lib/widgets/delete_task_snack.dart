import 'package:appwrite_project/models/task.dart';
import 'package:flutter/material.dart';

class DeleteTaskSnackBar extends SnackBar {
  //final ArchSampleLocalizations localizations;

  DeleteTaskSnackBar({
    Key key,
    @required Task task,
    @required VoidCallback onUndo,
    //@required this.localizations,
  }) : super(
          key: key,
          content: Text(
            'Deleted',
            // localizations.taskDeleted(task.task),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          duration: Duration(seconds: 2),
          action: SnackBarAction(
            textColor: Colors.white,
            label: 'Undo',
            onPressed: onUndo,
          ),
        );
}
