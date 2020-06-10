import 'package:flutter/material.dart';

class ArchSampleKeys {
  // Home Screens
  static const homeScreen = Key('__homeScreen__');
  static const addTaskFab = Key('__addTaskFab__');
  static const snackbar = Key('__snackbar__');
  static Key snackbarAction(String id) => Key('__snackbar_action_${id}__');

  // Tasks
  static const taskList = Key('__taskList__');
  static const tasksLoading = Key('__tasksLoading__');
  static final taskItem = (String id) => Key('TaskItem__${id}');
  static final taskItemCheckbox =
      (String id) => Key('TaskItem__${id}__Checkbox');
  static final taskItemTask = (String id) => Key('TaskItem__${id}__Task');
  static final taskItemNote = (String id) => Key('TaskItem__${id}__Note');

  // Tabs
  static const tabs = Key('__tabs__');
  static const taskTab = Key('__taskTab__');
  static const statsTab = Key('__statsTab__');

  // Extra Actions
  static const extraActionsButton = Key('__extraActionsButton__');
  static const toggleAll = Key('__markAllDone__');
  static const clearCompleted = Key('__clearCompleted__');

  // Filters
  static const filterButton = Key('__filterButton__');
  static const allFilter = Key('__allFilter__');
  static const activeFilter = Key('__activeFilter__');
  static const completedFilter = Key('__completedFilter__');

  // Stats
  static const statsCounter = Key('__statsCounter__');
  static const statsLoading = Key('__statsLoading__');
  static const statsNumActive = Key('__statsActiveItems__');
  static const statsNumCompleted = Key('__statsCompletedItems__');

  // Details Screen
  static const editTaskFab = Key('__editTaskFab__');
  static const deleteTaskButton = Key('__deleteTaskFab__');
  static const taskDetailsScreen = Key('__taskDetailsScreen__');
  static final detailsTaskItemCheckbox = Key('DetailsTask__Checkbox');
  static final detailsTaskItemTask = Key('DetailsTask__Task');
  static final detailsTaskItemNote = Key('DetailsTask__Note');

  // Add Screen
  static const addTaskScreen = Key('__addTaskScreen__');
  static const saveNewTask = Key('__saveNewTask__');
  static const taskField = Key('__taskField__');
  static const noteField = Key('__noteField__');

  // Edit Screen
  static const editTaskScreen = Key('__editTaskScreen__');
  static const saveTaskFab = Key('__saveTaskFab__');
}
