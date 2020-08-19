import 'package:ehidrive/models/user.dart';
import 'package:ehidrive/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:ehidrive/theme/theme.dart' as theme;

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formkey = GlobalKey<FormState>();
  String username, password;
  Auth auth = Auth();

  Future<void> signIn() async {
    var formState = _formkey.currentState;

    if (formState.validate()) {
      formState.save();
      var user = User(username: username, password: password);
      user.printAccount();
      auth.verifyUser(user: user, context: context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        automaticallyImplyLeading: false,
        title: Image.asset(
          "assets/ehidrive-logo.png",
          height: 50,
          width: 50,
        ),
      ),
      backgroundColor: theme.backgroundColor,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Form(
          key: _formkey,
          child: Center(
            child: Container(
              padding: EdgeInsets.all(25),
              child: ListView(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                children: <Widget>[
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    height: 50,
                    child: TextFormField(
                      maxLength: 10,
                      decoration: InputDecoration(
                        filled: true,
                        prefixIcon: Icon(
                          Icons.person,
                        ),
                        labelStyle: TextStyle(fontSize: 14),
                        labelText: "Username",
                        counterText: "",
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(),
                        ),
                      ),
                      keyboardType: TextInputType.text,
                      validator: (input) {
                        var output;
                        if (input.isEmpty) {
                          output = "Please type in your username";
                        }
                        return output;
                      },
                      onSaved: (input) => username = input.trim(),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 50,
                    child: TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        labelStyle: TextStyle(fontSize: 14),
                        prefixIcon: Icon(Icons.lock),
                        labelText: "Password",
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(),
                        ),
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      validator: (input) {
                        var output;
                        if (input.isEmpty) {
                          output = "Please type in your password";
                        }
                        return output;
                      },
                      onSaved: (input) => password = input.trim(),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RaisedButton(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Text(
                        "Sign In",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    onPressed: signIn,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
