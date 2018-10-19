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
    return new Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Container(
              padding: EdgeInsets.all(16.0),
              color: Colors.lightBlue,
              height: 200.0,
              width: 1000.0,
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Image.asset(
                    'images/vcdeca_white_trans.png',
                    width: 1000.0,
                    height: 125.0,
                  ),
                  new Text(
                    name,
                    style: TextStyle(
                        fontSize: 25.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              )
          ),
          new Padding(padding: EdgeInsets.all(8.0)),
          new Text(email),
          new Padding(padding: EdgeInsets.all(5.0)),
          new Text("Role: $role"),
          new Padding(padding: EdgeInsets.all(32.0)),
          new RaisedButton(
            color: Colors.red,
            textColor: Colors.white,
            child: new Text("Sign Out"),
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.of(context).pushReplacementNamed('/notLogged');
            },
          ),
          new RaisedButton(
            textColor: Colors.white,
            color: Colors.lightBlue,
            child: new Text("Test Firebase Upload!"),
            onPressed: testUpload,
          )
        ],
      ),
    );
  }
}
