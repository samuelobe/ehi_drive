import 'package:ehidrive/models/user.dart';
import 'package:ehidrive/services/auth.dart';
import 'package:ehidrive/widgets/global/custom_raised_button.dart';
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
      // appBar: AppBar(
      //   backgroundColor: Colors.grey,
      //   automaticallyImplyLeading: false,
      //   title: Text("Login"),
      // ),
      backgroundColor: theme.backgroundColor,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Form(
          key: _formkey,
          child: Center(
            child: Container(
              padding: EdgeInsets.all(35),
              child: ListView(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                children: <Widget>[
                  Image.asset(
                    "assets/ehidrive-logo.png",
                    height: MediaQuery.of(context).size.height * 0.15,
                    width: MediaQuery.of(context).size.width * 0.15,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 6,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: TextFormField(
                      enableSuggestions: false,
                      autocorrect: false,
                      maxLength: 10,
                      decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          contentPadding: EdgeInsets.zero,
                          filled: true,
                          prefixIcon: Icon(
                            Icons.person,
                          ),
                          labelStyle: TextStyle(fontSize: 14),
                          labelText: "Username",
                          counterText: "",
                          fillColor: Colors.white,
                          border: InputBorder.none),
                      keyboardType: TextInputType.emailAddress,
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
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 6,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: TextFormField(
                      enableSuggestions: false,
                      autocorrect: false,
                      obscureText: true,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          filled: true,
                          labelStyle: TextStyle(fontSize: 14),
                          prefixIcon: Icon(
                            Icons.lock,
                          ),
                          labelText: "Password",
                          fillColor: Colors.white,
                          border: InputBorder.none),
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
                  CustomRaisedButton(
                    text: "Sign In",
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
