class User {
  final String name;
  final String username;
  final String password;

  User({this.name, this.username, this.password});

  Map<String,dynamic> toMap(){
    return {
      'name':name,
      'username':username,
      'password':password
    };
  }
}
