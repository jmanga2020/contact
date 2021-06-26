import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  bool loading = false;

  //text field state
  String fullname = '';
  String username = '';
  // String email = '';
  String password = '';
  String error = '';

  TextEditingController _fullname = new TextEditingController();
  TextEditingController _username = new TextEditingController();
  TextEditingController _password = new TextEditingController();

  // Future<List> senddata() async {
  //   final response =
  //       await http.post("http://raushanjha.in/insertdata.php", body: {
  //     "name": name.text,
  //     "email": email.text,
  //     "mobile": mobile.text,
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration Page'),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
          ),
          padding: EdgeInsets.all(30.0),
          width: double.infinity,
          height: 620.0,
          child: ListView(
            children: [
              Form(
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
                      controller: _fullname,
                      onChanged: (val) {
                        setState(() => fullname = val);
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
                      controller: _username,
                      onChanged: (val) {
                        setState(() => username = val);
                      },
                      validator: (val) =>
                          val.isEmpty ? 'Enter Your Username' : null,
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
                      controller: _password,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                      obscureText: true,
                      validator: (val) => val.length < 6
                          ? 'Your Password need to be more than 6 character'
                          : null,
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
                    InkWell(
                      onTap: () => Navigator.pop(context),
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
                        // senddata;
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
            ],
          ),
        ),
      ),
    );
  }
}
