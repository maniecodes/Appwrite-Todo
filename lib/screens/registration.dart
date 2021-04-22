import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/blocs.dart';
import '../resources/user_repository.dart';
import './screens.dart';
import '../utils/utils.dart';

class Registration extends StatefulWidget {
  final UserRepository _userRepository;

  Registration({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final _nameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _onRegisterButtonPressed() {
      BlocProvider.of<RegistrationBloc>(context).add(RegistrationButtonPressed(
          email: _emailController.text,
          password: _passwordController.text,
          name: _nameController.text,
          phone: _phoneNumberController.text));
    }

    return BlocListener<RegistrationBloc, RegistrationState>(
      listener: (context, state) {
        if (state is RegistrationFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[Text(state.error), Icon(Icons.error)],
                ),
              ),
            );
        }
        if (state is RegistrationInitial) {
          Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
        }
      },
      child: BlocBuilder<RegistrationBloc, RegistrationState>(
          builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Sign Up',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  SizedBox(
                    height: 50,
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
                      controller: _nameController,
                      style: TextStyle(
                          fontSize: 20.0, height: 2.0, color: Colors.black),
                      decoration: InputDecoration(
                        hintText: 'Full name',
                        hintStyle:
                            TextStyle(fontSize: 20.0, color: Colors.grey),
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
                    height: 30,
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
                      controller: _phoneNumberController,
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                          fontSize: 20.0, height: 2.0, color: Colors.black),
                      decoration: InputDecoration(
                        hintText: 'Phone number',
                        hintStyle:
                            TextStyle(fontSize: 20.0, color: Colors.grey),
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
                    height: 30,
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
                        hintText: 'Email address',
                        hintStyle:
                            TextStyle(fontSize: 20.0, color: Colors.grey),
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
                    height: 30,
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
                        hintStyle:
                            TextStyle(fontSize: 20.0, color: Colors.grey),
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
                    height: 60,
                  ),
                  InkWell(
                    onTap: state is! RegistrationLoading
                        ? _onRegisterButtonPressed
                        : null,
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
                              ])),
                      child: Text(
                        'Register',
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
                          return LoginScreen(
                            userRepository: widget._userRepository,
                          );
                        }),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('You have an account? '),
                        Text('Login',
                            style: TextStyle(color: HexColor('#223FA1')))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
