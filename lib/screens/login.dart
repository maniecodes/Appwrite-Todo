import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/blocs.dart';
import '../resources/user_repository.dart';
import './screens.dart';
import '../utils/utils.dart';

class Login extends StatefulWidget {
  final UserRepository _userRepository;

  Login({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _onLoginButtonPressed() {
      BlocProvider.of<LoginBloc>(context).add(
        LoginButtonPressed(
          email: _emailController.text,
          password: _passwordController.text,
        ),
      );
    }

    return BlocListener<LoginBloc, LoginState>(listener: (context, state) {
      if (state is LoginFailure) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text(state.error), Icon(Icons.error)],
              ),
              backgroundColor: Colors.red,
            ),
          );
      }

      if (state is LoginInitial) {
        Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
      }
    }, child: BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Welcome Back !',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Image.asset(
                  'assets/illustration-2.png',
                  height: MediaQuery.of(context).size.height / 3,
                  fit: BoxFit.fitHeight,
                ),
                SizedBox(
                  height: 60,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.grey.shade400,
                          offset: Offset(1, 1),
                          blurRadius: 5,
                          spreadRadius: .5)
                    ],
                  ),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.always,
                    controller: _emailController,
                    style: TextStyle(
                        fontSize: 20.0, height: 2.0, color: Colors.black),
                    decoration: InputDecoration(
                      hintText: 'Email Address',
                      hintStyle: TextStyle(fontSize: 20.0, color: Colors.grey),
                      border: InputBorder.none,
                      // fillColor: Color(0xfff3f3f4),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.0)),
                    ),
                    autocorrect: false,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.grey.shade400,
                          offset: Offset(1, 1),
                          blurRadius: 5,
                          spreadRadius: .5)
                    ],
                  ),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.always,
                    controller: _passwordController,
                    style: TextStyle(
                        fontSize: 20.0, height: 2.0, color: Colors.black),
                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: TextStyle(fontSize: 20.0, color: Colors.grey),
                      border: InputBorder.none,
                      // fillColor: Color(0xfff3f3f4),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.0)),
                    ),
                    obscureText: true,
                    autocorrect: false,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: null,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(color: HexColor('#223FA1')),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: state is! LoginLoading ? _onLoginButtonPressed : null,
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2.7,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Colors.grey.shade500,
                              offset: Offset(2, 2),
                              blurRadius: 5,
                              spreadRadius: 2)
                        ],
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            HexColor('#223FA1'),
                            HexColor('#223FA1'),
                          ],
                        )),
                    child: Text(
                      'Login',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) {
                        return RegistrationScreen(
                          userRepository: widget._userRepository,
                        );
                      }),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('You do not have an account? '),
                      Text('Sign Up',
                          style: TextStyle(color: HexColor('#223FA1')))
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    ));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }
}
