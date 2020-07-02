import 'package:appwrite_project/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../authentication/authentication.dart';
import '../blocs/blocs.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DrawerBloc, DrawerState>(builder: (context, state) {
      if (state is DrawerLoadInProgress) {
        return CircularProgressIndicator();
      }
      final numFavourite = (state as DrawerLoadSuccess).numFavourite;
      final numTasks = (state as DrawerLoadSuccess).numTasks;
      final numComplete = (state as DrawerLoadSuccess).numComplete;
      final email = (state as DrawerLoadSuccess).email;
      final name = (state as DrawerLoadSuccess).name;
      return Drawer(
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('$name'),
              accountEmail: Text('$email'),
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
                    Navigator.pushNamed(context, TaskRoutes.home);
                  },
                ),
                ListTile(
                  title: Text('Tasks'),
                  leading: Icon(Icons.assignment_turned_in),
                  trailing: Text(numTasks.toString()),
                  onTap: null,
                ),
                ListTile(
                  title: Text('Favourite'),
                  leading: Icon(Icons.favorite),
                  trailing: Text(numFavourite.toString()),
                  onTap: null,
                ),
                ListTile(
                  title: Text('Completed'),
                  leading: Icon(Icons.assignment_turned_in),
                  trailing: Text(numComplete.toString()),
                  onTap: null,
                ),
                ListTile(
                  title: Text('Logout'),
                  leading: Icon(Icons.exit_to_app),
                  onTap: () {
                    BlocProvider.of<AuthenticationBloc>(context)
                        .add(LoggedOut());
                  },
                )
              ],
            ),
          ],
        ),
      );
    });
  }
}
