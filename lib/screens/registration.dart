import 'package:appwrite_project/utils/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../authentication/authentication_bloc.dart';
import '../blocs/registration/registration_bloc.dart';
import '../resources/user_repository.dart';
import '../screens/login_screen.dart';

class Registration extends StatefulWidget {
  final UserRepository _userRepository;
  final String name;
  final String phoneNumber;

  Registration(
      {Key key,
      @required UserRepository userRepository,
      @required this.name,
      @required this.phoneNumber})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  RegistrationBloc _registrationBloc;

  UserRepository get _userRepository => widget._userRepository;

  //check if fields are not empty
  bool get isPopulated =>
      _nameController.text.isNotEmpty &&
      _phoneNumberController.text.isNotEmpty &&
      _emailController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty;

  //check if button is enabled
  bool isRegisterButtonEnabled(RegistrationState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _registrationBloc = BlocProvider.of<RegistrationBloc>(context);
    _nameController.addListener(_onNameChanged);
    _phoneNumberController.addListener(_onPhoneNumberChanged);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegistrationBloc, RegistrationState>(
      listener: (context, state) {
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text(state.isError), Icon(Icons.error)],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }

        if (state.isSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Registering...'),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        }
        if (state.isSuccess) {
          print('here');
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
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
                      //  obscureText: true,
                      autovalidate: true,
                      autocorrect: false,
                    ),
                  ),
                  !state.isNameValid
                      ? Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              child: Text(
                                "Kinldy Input text only",
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ),
                        )
                      : Text(''),
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
                      //  obscureText: true,
                      autovalidate: true,
                      autocorrect: false,
                    ),
                  ),
                  !state.isPhoneNumberValid
                      ? Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              child: Text(
                                "Input correct phone number",
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ),
                        )
                      : Text(''),
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
                      // obscureText: true,
                      autovalidate: true,
                      autocorrect: false,
                    ),
                  ),
                  !state.isEmailValid
                      ? Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              child: Text(
                                "Invalid Email",
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ),
                        )
                      : Text(''),
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
                      autovalidate: true,
                      autocorrect: false,
                    ),
                  ),
                  !state.isPasswordValid
                      ? Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              child: Text(
                                "Invalid Password",
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ),
                        )
                      : Text(''),
                  SizedBox(
                    height: 60,
                  ),
                  InkWell(
                    onTap: isRegisterButtonEnabled(state)
                        ? _onFormSubmitted
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
                            userRepository: _userRepository,
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

  void _onNameChanged() {
    _registrationBloc.add(
      NameChanged(name: _nameController.text),
    );
  }

  void _onPhoneNumberChanged() {
    _registrationBloc.add(
      PhoneNumberChanged(phoneNumber: _phoneNumberController.text),
    );
  }

  void _onEmailChanged() {
    _registrationBloc.add(
      EmailChanged(email: _emailController.text),
    );
  }

  void _onPasswordChanged() {
    _registrationBloc.add(
      PasswordChanged(password: _passwordController.text),
    );
  }

  void _onFormSubmitted() {
    _registrationBloc.add(
      RegistrationSubmitted(
          email: _emailController.text,
          password: _passwordController.text,
          name: _nameController.text),
    );
  }
}
