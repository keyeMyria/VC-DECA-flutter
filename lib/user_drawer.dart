import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:vc_deca/main.dart';
import 'package:vc_deca/user_info.dart';

class UserDrawer extends StatefulWidget {
  @override
  _UserDrawerState createState() => _UserDrawerState();
}

class _UserDrawerState extends State<UserDrawer> {
  
  final databaseRef = FirebaseDatabase.instance.reference();


  @override
  void initState() {
    super.initState();
  }
  
  void testUpload() {
    databaseRef.reference().child("testing").push().set({
      "Test": "$userID - $name"
    });
  }

  @override
  Widget build(BuildContext context) {
    return new SafeArea(
      child: Container(
        padding: EdgeInsets.all(32.0),
        child: Center(
          child: Column(
            children: <Widget>[
              new Text("Hello User Drawer!"),
              new Text(name),
              new Text(email),
              new Text("Role: $role"),
              new RaisedButton(
                child: new Text("Sign Out"),
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushReplacementNamed('/notLogged');
                },
              ),
              new RaisedButton(
                child: new Text("Test Firebase Upload\n$name!"),
                onPressed: testUpload,
              )
            ],
          ),
        ),
      ),
    );
  }
}
