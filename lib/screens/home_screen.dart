import 'package:appwrite_project/authentication/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () {
            BlocProvider.of<AuthenticationBloc>(context).add(
              LoggedOut(),
            );
          },
          child: Text('Logout'),
        ),
      ),
    );
  }
}
