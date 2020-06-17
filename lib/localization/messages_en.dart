import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = MessageLookup();

// ignore: unused_element
final _keepAnalysisHappy = Intl.defaultLocale;

// ignore: non_constant_identifier_names
typedef MessageIfAbsent = void Function(String message_str, List args);

class MessageLookup extends MessageLookupByLibrary {
  @override
  String get localeName => 'en';

  static String m0(task) => 'Deleted "$task"';

  @override
  final messages = _notInlinedMessages(_notInlinedMessages);

  static Map<String, dynamic> _notInlinedMessages(_) => {
        'activeTasks': MessageLookupByLibrary.simpleMessage('Active Tasks'),
        'addTask': MessageLookupByLibrary.simpleMessage('Add Task'),
        'cancel': MessageLookupByLibrary.simpleMessage('Cancel'),
        'clearCompleted':
            MessageLookupByLibrary.simpleMessage('Clear completed'),
        'completedTasks':
            MessageLookupByLibrary.simpleMessage('Completed Tasks'),
        'delete': MessageLookupByLibrary.simpleMessage('Delete'),
        'deleteTask': MessageLookupByLibrary.simpleMessage('Delete Task'),
        'deleteTaskConfirmation':
            MessageLookupByLibrary.simpleMessage('Delete this task?'),
        'editTask': MessageLookupByLibrary.simpleMessage('Edit Task'),
        'emptyTaskError':
            MessageLookupByLibrary.simpleMessage('Please enter some text'),
        'filterTasks': MessageLookupByLibrary.simpleMessage('Filter Tasks'),
        'markAllComplete':
            MessageLookupByLibrary.simpleMessage('Mark all complete'),
        'markAllIncomplete':
            MessageLookupByLibrary.simpleMessage('Mark all incomplete'),
        'newTaskHint':
            MessageLookupByLibrary.simpleMessage('What needs to be done?'),
        'descriptionHint':
            MessageLookupByLibrary.simpleMessage('Additional Notes...'),
        'saveChanges': MessageLookupByLibrary.simpleMessage('Save changes'),
        'showActive': MessageLookupByLibrary.simpleMessage('Show Active'),
        'showAll': MessageLookupByLibrary.simpleMessage('Show All'),
        'showCompleted': MessageLookupByLibrary.simpleMessage('Show Completed'),
        'stats': MessageLookupByLibrary.simpleMessage('Stats'),
        'taskDeleted': m0,
        'taskDetails': MessageLookupByLibrary.simpleMessage('Task Details'),
        'tasks': MessageLookupByLibrary.simpleMessage('Tasks'),
        'undo': MessageLookupByLibrary.simpleMessage('Undo')
      };
}
