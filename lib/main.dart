import 'package:flutter/material.dart';
import 'package:vc_deca/register_page.dart';
import 'package:vc_deca/welcome.dart';
import 'package:vc_deca/tab_bar_controller.dart';

void main() {
  runApp(new MaterialApp(
    title: "VC DECA",
    home: WelcomePage(),
    routes: <String, WidgetBuilder> {
      '/logged': (BuildContext context) => new TabBarController(),
      '/notLogged' : (BuildContext context) => new RegisterPage()
    },
    debugShowCheckedModeBanner: false,
  ));
}