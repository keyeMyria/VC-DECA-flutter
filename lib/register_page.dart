import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  String _name;
  String _email;
  String _password;
  String _confirm;

  void register() async {
    if (_confirm == _password || _name != "" || _email != "") {
      try {
        FirebaseUser user = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: _email, password: _password);
        print("Signed in! ${user.uid}");
      }
      catch (error) {
        print("Error: $error");
      }
    }
    else {
      print("Missing info");
    }
  }

  void nameField(input) {
    _name = input;
  }

  void emailField(input) {
    _email = input;
  }

  void passwordField(input) {
    _password = input;
  }

  void confirmField(input) {
    _confirm = input;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
              new Text("Create your VC DECA Acoount below!"),
              new Padding(padding: EdgeInsets.all(8.0)),
              new TextField(
                decoration: InputDecoration(
                  icon: new Icon(Icons.person),
                  labelText: "Name",
                  hintText: "Enter your name"
                ),
                autocorrect: true,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.words,
                onChanged: nameField,
              ),
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
              new TextField(
                decoration: InputDecoration(
                    icon: new Icon(Icons.person),
                    labelText: "Confirm Password",
                    hintText: "Confirm your password"
                ),
                autocorrect: true,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.none,
                obscureText: true,
                onChanged: confirmField,
              ),
              new Padding(padding: EdgeInsets.all(8.0)),
              new RaisedButton(
                child: new Text("Create Account"),
                onPressed: register,
                color: Colors.lightBlue,
                textColor: Colors.white,
                highlightColor: Colors.lightBlueAccent,
              )
            ],
          ),
        ),
      ),
    );
  }
}
