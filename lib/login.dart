import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:vc_deca/user_info.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {

  String _email = "";
  String _password = "";

  final databaseRef = FirebaseDatabase.instance.reference();

  void login() async {
    try {
      FirebaseUser user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _email, password: _password);
      print("Signed in! ${user.uid}");

      userID = user.uid;

      databaseRef.child("users").child(userID).update({
        "name": name,
        "email": email,
        "role": role,
        "userID": userID
      });

      Navigator.of(context).pushReplacementNamed('/registered');
    }
    catch (error) {
      print("Error: $error");
    }
  }

  void emailField(input) {
    _email = input;
  }

  void passwordField(input) {
    _password = input;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Text(
          "VC DECA",
          style: TextStyle(
              fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: new Container(
        padding: EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 32.0),
        child: new Center(
          child: new Column(
            children: <Widget>[
              new Text("Login to your VC DECA Account below!"),
              new Padding(padding: EdgeInsets.all(8.0)),
              new TextField(
                decoration: InputDecoration(
                    icon: new Icon(Icons.email),
                    labelText: "Email",
                    hintText: "Enter your email"
                ),
                autocorrect: true,
                keyboardType: TextInputType.emailAddress,
                textCapitalization: TextCapitalization.none,
                onChanged: emailField,
              ),
              new TextField(
                decoration: InputDecoration(
                    icon: new Icon(Icons.lock),
                    labelText: "Password",
                    hintText: "Enter a password"
                ),
                autocorrect: true,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.none,
                obscureText: true,
                onChanged: passwordField,
              ),
              new Padding(padding: EdgeInsets.all(8.0)),
              new RaisedButton(
                child: new Text("Login"),
                onPressed: login,
                color: Colors.lightBlue,
                textColor: Colors.white,
                highlightColor: Colors.lightBlueAccent,
              ),
              new Padding(padding: EdgeInsets.all(16.0)),
              new FlatButton(
                child: new Text(
                  "Don't have an account?",
                  style: TextStyle(
                    color: Colors.lightBlue,
                  ),
                ),
                splashColor: Colors.lightBlueAccent,
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/toRegister');
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}