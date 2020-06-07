import 'package:appwrite_project/screens/login_screen.dart';
import 'package:appwrite_project/utils/hex_color.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
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
      body: SingleChildScrollView(
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
                    //  controller: _passwordController,
                    style: TextStyle(
                        fontSize: 20.0, height: 2.0, color: Colors.black),
                    decoration: InputDecoration(
                      hintText: 'Full name',
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
                    //  obscureText: true,
                    autovalidate: true,
                    autocorrect: false,
                    validator: (_) {
                      //     return !state.isPasswordValid ? 'Invalid Password' : null;
                    },
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
                    //  controller: _passwordController,
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                        fontSize: 20.0, height: 2.0, color: Colors.black),
                    decoration: InputDecoration(
                      hintText: 'Phone number',
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
                    autovalidate: true,
                    autocorrect: false,
                    validator: (_) {
                      //     return !state.isPasswordValid ? 'Invalid Password' : null;
                    },
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
                    //  controller: _passwordController,
                    style: TextStyle(
                        fontSize: 20.0, height: 2.0, color: Colors.black),
                    decoration: InputDecoration(
                      hintText: 'Email address',
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
                    // obscureText: true,
                    autovalidate: true,
                    autocorrect: false,
                    validator: (_) {
                      //     return !state.isPasswordValid ? 'Invalid Password' : null;
                    },
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
                    //  controller: _passwordController,
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
                    autovalidate: true,
                    autocorrect: false,
                    validator: (_) {
                      //     return !state.isPasswordValid ? 'Invalid Password' : null;
                    },
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) {
                        //    return LoginScreen();
                      }),
                    );
                  },
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
                        return LoginScreen();
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
      ),
    );
  }
}
