import 'package:contact_tracing/services/utils/navigation.dart';
import 'package:flutter/material.dart';

import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Center(
        child: Container(
          margin: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.black12,
          ),
          width: double.infinity,
          height: 420.0,
          padding: EdgeInsets.all(20.0),
          child: ListView(
            children: [
              Form(
                child: Column(
                  children: [
                    Text(
                      'LAB TECH',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      onChanged: null,
                      validator: (val) =>
                          val.isEmpty ? 'Enter Your username' : null,
                      decoration: InputDecoration(
                        labelText: 'Username',
                        contentPadding: EdgeInsets.all(20.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      obscureText: true,
                      onChanged: null,
                      validator: (val) =>
                          val.isEmpty ? 'Enter Your password' : null,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        contentPadding: EdgeInsets.all(20.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    // ignore: deprecated_member_use
                    RaisedButton(
                      onPressed: () => {},
                      color: Colors.green,
                      textColor: Colors.white,
                      child: Text(
                        'LOGIN',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    InkWell(
                      onTap: () => UserNavigation.push(context,
                          destination: RegisterScreen()),
                      child: Text(
                        'Don\'t have an account?',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Text(
                      'error',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 14.0,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
