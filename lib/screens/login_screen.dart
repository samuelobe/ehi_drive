import 'package:ehidrive/models/user.dart';
import 'package:ehidrive/services/auth.dart';
import 'package:flutter/material.dart';

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
      appBar: AppBar(backgroundColor: Color(0xFFebebeb), automaticallyImplyLeading: false, elevation:  0, brightness: Brightness.light,),
      backgroundColor: Color(0xFFebebeb),
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
                  Image.asset(
                    "assets/ehidrive-logo.png",
                    height: MediaQuery.of(context).size.height * 0.15,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    maxLength: 10,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      labelText: "Username",
                      counterText: "",
                      fillColor: Colors.white,
                      // border: OutlineInputBorder(
                      //   borderRadius: BorderRadius.circular(10.0),
                      //   borderSide: BorderSide(),
                      // ),
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
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      labelText: "Password",
                      fillColor: Colors.white,
                      // border: OutlineInputBorder(
                      //   borderRadius: BorderRadius.circular(10.0),
                      //   borderSide: BorderSide(),
                      // ),
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
                  SizedBox(
                    height: 30,
                  ),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Text(
                        "Sign In",
                        style: TextStyle(fontSize: 22),
                      ),
                    ),
                    onPressed: signIn,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
