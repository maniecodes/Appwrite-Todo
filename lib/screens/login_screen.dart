import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/blocs.dart';
import '../resources/user_repository.dart';
import './screens.dart';
import '../authentication/authentication.dart';

class LoginScreen extends StatelessWidget {
  final UserRepository _userRepository;

  LoginScreen({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(
              userRepository: _userRepository,
              authenticationBloc: BlocProvider.of<AuthenticationBloc>(context)),
          child: SingleChildScrollView(
            child: Login(
              userRepository: _userRepository,
            ),
          )),
    );
  }
}
