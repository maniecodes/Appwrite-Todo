import 'package:appwrite_project/utils/app_theme.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Form(
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                Image.asset(
                  'assets/join.png',
                  height: MediaQuery.of(context).size.height / 3,
                  fit: BoxFit.fitHeight,
                ),
                SizedBox(
                  height: 50,
                ),
                Center(
                  child: Text(
                    'Welcome',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      // color: AppTheme.getTheme().colorScheme.primary
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    "This is a note app built with",
                    style: TextStyle(fontSize: 16, color: HexColor('#928F8F')),
                  ),
                ),
                Center(
                  child: Text(
                    "flutter and appwrite",
                    style: TextStyle(fontSize: 16, color: HexColor('#928F8F')),
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
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
                        'Login',
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20, color: Colors.white),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2.7,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.grey.shade400,
                                offset: Offset(2, 2),
                                blurRadius: 5,
                                spreadRadius: 1)
                          ],
                          gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Colors.white,
                                Colors.white,
                              ])),
                      child: Text(
                        'Sign up',
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20, color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
