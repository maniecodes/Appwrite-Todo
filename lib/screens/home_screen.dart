import 'package:flutter/material.dart';
import '../widgets/widgets.dart';
import '../screens/screens.dart';
import '../utils/utils.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(FlutterBlocLocalizations.of(context).appTitle)
      ),
      drawer: AppDrawer(),
      body: FilteredTasks(),
      floatingActionButton: FloatingActionButton(
        key: TasksKeys.addTaskFab,
        onPressed: () {
          Navigator.pushNamed(context, TaskRoutes.addTask);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
