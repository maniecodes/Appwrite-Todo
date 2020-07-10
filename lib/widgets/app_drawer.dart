import 'package:appwrite_project/models/models.dart';
import 'package:appwrite_project/models/task.dart';
import 'package:appwrite_project/utils/utils.dart';
import 'package:appwrite_project/widgets/screen_argument.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../authentication/authentication.dart';

class AppDrawer extends StatelessWidget {
  final List<Task> tasks;
  final User user;
  AppDrawer({Key key, @required this.tasks, @required this.user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(user.name),
            accountEmail: Text(user.email),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
            ),
          ),
          Column(
            children: <Widget>[
              ListTile(
                title: Text('Home'),
                leading: Icon(Icons.home),
                onTap: () {
                  Navigator.pushReplacementNamed(context, TaskRoutes.home);
                },
              ),
              ListTile(
                title: Text('Tasks'),
                leading: Icon(Icons.assignment_turned_in),
                trailing: Text(tasks.length.toString()),
                onTap: () {
                  Navigator.pushReplacementNamed(context, TaskRoutes.viewTasks,
                      arguments: ScreenArguments(tasks));
                },
              ),
              ListTile(
                title: Text('Favourite'),
                leading: Icon(Icons.favorite),
                trailing: Text(tasks
                    .where((task) => task.favourite)
                    .toList()
                    .length
                    .toString()),
                onTap: () {
                  Navigator.pushReplacementNamed(
                      context, TaskRoutes.favouriteTasks,
                      arguments: ScreenArguments(tasks));
                },
              ),
              ListTile(
                title: Text('Completed'),
                leading: Icon(Icons.assignment_turned_in),
                trailing: Text(tasks
                    .where((task) => task.complete)
                    .toList()
                    .length
                    .toString()),
                onTap: () {
                  Navigator.pushReplacementNamed(
                      context, TaskRoutes.completedTasks,
                      arguments: ScreenArguments(tasks));
                },
              ),
              ListTile(
                title: Text('Logout'),
                leading: Icon(Icons.exit_to_app),
                onTap: () {
                  BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
