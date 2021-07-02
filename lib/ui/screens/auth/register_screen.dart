import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contact_tracing/services/utils/navigation.dart';
import 'package:contact_tracing/ui/screens/animation/loaders.dart';
import 'package:flutter/material.dart';
import 'package:contact_tracing/services/cloud/operations.dart';
import 'package:uuid/uuid.dart';
import 'package:contact_tracing/models/user.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  List<String> _usernames = [];

  Future<void> _getAllUsers() async {
    FirebaseFirestore.instance.collection('Users').get().then((value) {
      if (value != null) {
        for (var i in value.docs) {
          Map<String, dynamic> _data = i.data();
          _usernames.add(_data['username']);
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _getAllUsers();
  }

  final _formKey = GlobalKey<FormState>();

  bool loading = false;

  //text field state
  String _fullname = '';
  String _username = '';
  // String email = '';
  String _password = '';
  String error = '';

  bool _isLoading = false;
  bool _obscure = true;

  void _obscuring() {
    setState(() {
      _obscure = !_obscure;
    });
  }

  TextEditingController _fullnameController = new TextEditingController();
  TextEditingController _usernameController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _isLoading
            ? UniversalLoader(
                label: 'Registering a user, please wait...',
              )
            : Center(
                child: Container(
                  margin: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding: EdgeInsets.all(30.0),
                  width: double.infinity,
                  height: 620.0,
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Text(
                            'REGISTER',
                            style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.brown,
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          TextFormField(
                            controller: _fullnameController,
                            onChanged: (val) {
                              setState(() => _fullname = val);
                            },
                            validator: (val) =>
                                val.isEmpty ? 'Enter Your Name' : null,
                            decoration: InputDecoration(
                              labelText: 'Fullname',
                              contentPadding: EdgeInsets.all(20.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),

                          TextFormField(
                            controller: _usernameController,
                            onChanged: (val) {
                              setState(() => _username = val);
                            },
                            validator: (val) {
                              if (val.isEmpty) {
                                return 'Enter Your Username';
                              } else if (_username.contains(val)) {
                                return 'Username is already in use';
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              labelText: 'Username',
                              contentPadding: EdgeInsets.all(20.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),

                          // TextFormField(
                          //   onChanged: (val) {
                          //     setState(() => email = val);
                          //   },
                          //   validator: (val) =>
                          //       val.isEmpty ? 'Enter Your Email' : null,
                          //   decoration: InputDecoration(
                          //     labelText: 'Email',
                          //     contentPadding: EdgeInsets.all(20.0),
                          //     border: OutlineInputBorder(
                          //       borderRadius: BorderRadius.circular(20.0),
                          //     ),
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: 30.0,
                          // ),

                          TextFormField(
                            controller: _passwordController,
                            onChanged: (val) {
                              setState(() => _password = val);
                            },
                            obscureText: _obscure,
                            validator: (val) => val.length < 6
                                ? 'Your Password need to be more than 6 character'
                                : null,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  icon: Icon(_obscure
                                      ? Icons.remove_red_eye_sharp
                                      : Icons.camera),
                                  onPressed: () => _obscuring()),
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
                          InkWell(
                            onTap: () => UserNavigation.pop(context),
                            child: Text(
                              'I have an account',
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),

                          // ignore: deprecated_member_use
                          RaisedButton(
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                setState(() {
                                  _isLoading = true;
                                });
                                _formKey.currentState.save();
                                var _id = Uuid().v4();
                                try {
                                  await CloudOperations.addToCloud(
                                      serverPath: 'Users/$_id',
                                      data: User(
                                              id: _id,
                                              name: _fullname,
                                              password: _password,
                                              username: _username)
                                          .toMap());
                                  setState(() {
                                    _fullnameController.clear();
                                    _usernameController.clear();
                                    _passwordController.clear();
                                    _isLoading = false;
                                  });
                                  UserNavigation.pop(context);
                                } catch (e) {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                }
                              }
                            },
                            padding: EdgeInsets.all(20.0),
                            color: Theme.of(context).primaryColor,
                            textColor: Colors.white,
                            child: Text(
                              'REGISTER',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 12.0,
                          ),
                          Text(
                            error,
                            style: TextStyle(color: Colors.red, fontSize: 14.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
