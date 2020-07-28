import 'package:flutter/material.dart';

class User {
  final String username;
  final String password;
  User({@required this.username, @required this.password});

  printAccount() {
    print("Username: $username, Password: $password");
  }
}
