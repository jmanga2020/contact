class User {
  final String name;
  final String username;
  final String password;
  final String id;

  User({this.name, this.username, this.password,this.id});

  Map<String, dynamic> toMap() {
    return {'name': name, 'username': username, 'password': password,'id':id};
  }
}
