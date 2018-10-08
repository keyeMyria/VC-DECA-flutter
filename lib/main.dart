import 'dart:async';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vc_deca/alert_view.dart';
import 'package:vc_deca/login.dart';
import 'package:vc_deca/network_checker.dart';
import 'package:vc_deca/onboarding_page.dart';
import 'package:vc_deca/register_page.dart';
import 'package:vc_deca/auth_checker.dart';
import 'package:vc_deca/tab_bar_controller.dart';

Future <void> main() async {
//  final FirebaseApp app = await FirebaseApp.configure(
//    name: 'vc-deca',
//    options: Platform.isIOS
//        ? const FirebaseOptions(
//      googleAppID: '1:946014932243:ios:7ff8d9cacecec349',
//      gcmSenderID: '297855924061',
//      databaseURL: 'https://vc-deca.firebaseio.com',
//    )
//        : const FirebaseOptions(
//      googleAppID: '1:946014932243:android:7ff8d9cacecec349',
//      apiKey: 'AIzaSyD_shO5mfO9lhy2TVWhfo1VUmARKlG4suk',
//      databaseURL: 'https://vc-deca.firebaseio.com',
//    ),
//  );

  runApp(new MaterialApp(
    title: "VC DECA",
    home: ConnectionChecker(),
    routes: <String, WidgetBuilder> {
      '/checkConnection': (BuildContext context) => new ConnectionChecker(),
      '/checkAuth': (BuildContext context) => new AuthChecker(),
      '/logged': (BuildContext context) => new TabBarController(),
      '/notLogged' : (BuildContext context) => new OnboardingPage(),
      '/toRegister' : (BuildContext context) => new RegisterPage(),
      '/toLogin' : (BuildContext context) => new LoginPage(),
      '/registered': (BuildContext context) => new TabBarController(),
      '/alert': (BuildContext context) => new AlertPage(),
    },
    debugShowCheckedModeBanner: false,
  ));
}