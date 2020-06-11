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
      print(numFavourite);
      return Drawer(
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('Manasseh Abiodun'),
              accountEmail: Text('manassehl9@gmail.com'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
              ),
            ),
            Column(
              children: <Widget>[
                ListTile(
                  title: Text('Home'),
                  leading: Icon(Icons.home),
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
