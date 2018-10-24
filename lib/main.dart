import 'dart:async';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:vc_deca/bug_report.dart';
import 'package:vc_deca/network_check_again.dart';
import 'package:vc_deca/user_info.dart';
import 'package:flutter/material.dart';
import 'package:vc_deca/alert_view.dart';
import 'package:vc_deca/chaperone_chat.dart';
import 'package:vc_deca/event_category.dart';
import 'package:vc_deca/event_view.dart';
import 'package:vc_deca/global_chat.dart';
import 'package:vc_deca/login.dart';
import 'package:vc_deca/network_checker.dart';
import 'package:vc_deca/officer_chat.dart';
import 'package:vc_deca/onboarding_page.dart';
import 'package:vc_deca/register_page.dart';
import 'package:vc_deca/auth_checker.dart';
import 'package:vc_deca/tab_bar_controller.dart';
import 'package:fluro/fluro.dart';

void main() {
//  final FirebaseApp app = await FirebaseApp.configure(
//    name: 'vc-deca',
//    options: Platform.isIOS
//        ? const FirebaseOptions(
//      googleAppID: '1:946014932243:ios:7ff8d9cacecec349',®
//      gcmSenderID: '297855924061',
//      databaseURL: 'https://vc-deca.firebaseio.com',
//    )
//        : const FirebaseOptions(
//      googleAppID: '1:946014932243:android:7ff8d9cacecec349',
//      apiKey: 'AIzaSyD_shO5mfO9lhy2TVWhfo1VUmARKlG4suk',
//      databaseURL: 'https://vc-deca.firebaseio.com',
//    ),
//  );

  router.define('/checkConnection', handler: new Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return new ConnectionChecker();
  }));

  router.define('/checkConnectionAgain', handler: new Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return new ConnectionCheckerAgain();
  }));

  router.define('/alert', handler: new Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return new AlertPage();
  }));

  router.define('/checkAuth', handler: new Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return new AuthChecker();
  }));

  router.define('/logged', handler: new Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return new TabBarController();
  }));

  router.define('/notLogged', handler: new Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return new OnboardingPage();
  }));

  router.define('/toRegister', handler: new Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return new RegisterPage();
  }));

  router.define('/toLogin', handler: new Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return new LoginPage();
  }));

  router.define('/registered', handler: new Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return new TabBarController();
  }));

  router.define('/globalChat', handler: new Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return new GlobalChatPage();
  }));

  router.define('/officerChat', handler: new Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return new OfficerChatPage();
  }));

  router.define('/chapChat', handler: new Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return new ChaperoneChatPage();
  }));

  router.define('/event', handler: new Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return new EventPage();
  }));

  router.define('/eventCategory', handler: new Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return new EventCategoryPage();
  }));

  router.define('/bugReport', handler: new Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return new BugReportPage();
  }));

  runApp(new MaterialApp(
    title: "VC DECA",
    home: ConnectionChecker(),
    onGenerateRoute: router.generator,
    debugShowCheckedModeBanner: false,
  ));
}