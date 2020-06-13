import 'package:appwrite_project/blocs/tasks/tasks_bloc.dart';
import 'package:appwrite_project/screens/filtered_tasks.dart';
import 'package:appwrite_project/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/app_drawer.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Home'),
      ),
      drawer: AppDrawer(),
      body: FilteredTasks(),
      floatingActionButton: FloatingActionButton(
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
