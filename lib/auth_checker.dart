import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:vc_deca/register_page.dart';
import 'package:vc_deca/tab_bar_controller.dart';
import 'dart:async';

import 'package:vc_deca/user_info.dart';

class AuthChecker extends StatefulWidget {
  @override
  _AuthCheckerState createState() => _AuthCheckerState();
}

class _AuthCheckerState extends State<AuthChecker> {

  final databaseRef = FirebaseDatabase.instance.reference();

  Future<void> checkUserLogged() async {
    var user = await FirebaseAuth.instance.currentUser();
    if (user != null) {
      //User logged in
      print("User Logged");
      userID = user.uid;

      databaseRef.child("users").child(userID).once().then((DataSnapshot snapshot) {
        var userInfo = snapshot.value;
        email = userInfo["email"];
        role = userInfo["role"];
        name = userInfo["name"];
        chapGroupID = userInfo["group"];
      });

      Navigator.of(context).pushReplacementNamed('/logged');
    }
    else {
      //User log required
      print("User Not Logged");
      Navigator.of(context).pushReplacementNamed('/notLogged');
    }
  }

  @override
  void initState() {
    super.initState();
    checkUserLogged();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
    );
  }
}
