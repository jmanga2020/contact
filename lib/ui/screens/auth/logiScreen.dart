import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contact_tracing/services/metrics/deviceMetrics.dart';
import 'package:contact_tracing/services/utils/navigation.dart';
import 'package:contact_tracing/services/utils/shared.dart';
import 'package:contact_tracing/ui/screens/animation/loaders.dart';
import 'package:contact_tracing/ui/screens/records/patient_records.dart';
import 'package:contact_tracing/ui/widgets/notification.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  List<QueryDocumentSnapshot> _snapshot;

  Future<void> _getAllUsers() async {
    await FirebaseFirestore.instance.collection('Users').get().then((value) {
      setState(() {
        _snapshot = value.docs;
      });
    });
  }

  @override
  void initState() {
    _getAllUsers();
    super.initState();
  }

  final _key = GlobalKey<FormState>();

  Future<bool> _signInValidator() async {
    bool _ret = false;
    if (_snapshot != null) {
      for (var i in _snapshot) {
        Map<String, dynamic> _data = i.data();
        if (_data['username'] == _username) {
          if (_data['password'] == _password) {
            setState(() {
              _ret = true;
            });
          }
          break;
        }
      }
    } else {
      setState(() {
        _ret = false;
      });
    }
    return _ret;
  }

  String _username = '';
  String _password = '';
  bool _loader = false;

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  _visibility() {
    setState(() {
      _visible = !_visible;
    });
  }

  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: _loader
          ? UniversalLoader(
              label: 'Logging In, please wait...',
            )
          : Scaffold(
              body: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/icon3.png',
                      height: DeviceMetrics.deviceHeight(context) / 10,
                    ),
                    Container(
                      margin: EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.black12,
                      ),
                      width: double.infinity,
                      height: 420.0,
                      padding: EdgeInsets.all(20.0),
                      child: Form(
                        key: _key,
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
                              controller: _usernameController,
                              onChanged: (_usernameController) {
                                setState(() {
                                  _username = _usernameController;
                                });
                              },
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
                              controller: _passwordController,
                              obscureText: _visible,
                              onChanged: (_passwordController) {
                                setState(() {
                                  _password = _passwordController;
                                });
                              },
                              validator: (val) =>
                                  val.isEmpty ? 'Enter Your password' : null,
                              decoration: InputDecoration(
                                suffix: InkWell(
                                  onTap: () => _visibility(),
                                  child: Icon(
                                    !_visible
                                        ? FontAwesomeIcons.eyeSlash
                                        : FontAwesomeIcons.eye,
                                    size: 20,
                                  ),
                                ),
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
                              onPressed: () async {
                                if (_key.currentState.validate()) {
                                  setState(() {
                                    _loader = true;
                                  });
                                  _key.currentState.save();
                                  await _signInValidator().then((value) async {
                                    if (value) {
                                      TempMemory.writeString(
                                          key: 'admin', value: 'tech');
                                      setState(() {
                                        _passwordController.clear();
                                        _usernameController.clear();
                                        _loader = false;
                                      });
                                      UserNavigation.pushReplace(context,
                                          destination: PatientRecords());
                                      showSnack(context,
                                          content: 'You are logged In.');
                                    } else {
                                      showSnack(context,
                                          error: true,
                                          content:
                                              'Please check up your details.');
                                      setState(() {
                                        _loader = false;
                                      });
                                    }
                                  });
                                }
                              },
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
                            // Text(
                            //   'error',
                            //   style: TextStyle(
                            //     color: Colors.red,
                            //     fontSize: 14.0,
                            //   ),
                            // )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
    );
  }
}
