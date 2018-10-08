import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:vc_deca/home_page.dart';
import 'package:vc_deca/setting_page.dart';
import 'package:vc_deca/schedule_page.dart';
import 'package:vc_deca/chat_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vc_deca/user_drawer.dart';
import 'package:vc_deca/user_info.dart';

class TabBarController extends StatefulWidget {
  @override
  _TabBarControllerState createState() => _TabBarControllerState();
}

class _TabBarControllerState extends State<TabBarController> {
  String title = "VC DECA";

  PageController pageController;
  int currentTab = 0;

  var currentTabButton;
  var currentButton;

  var newAlertTitle = "";
  var newAlertBody = "";

  var newAlertButton = new FloatingActionButton(
    child: Icon(Icons.add),
  );

  void alertTitleText(String input) {
    newAlertTitle = input;
  }

  void alertBodyText(String input) {
    newAlertBody = input;
  }

  void addAlertDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Create New Announcement"),
          content: new Column(
            children: <Widget>[
              new TextField(
                onChanged: alertTitleText,
                decoration: InputDecoration(
                    labelText: "Announcement Title",
                    hintText: "Enter announcement title"
                ),
              ),
            ],
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text("CREATE"),
              onPressed: () {
                if (newAlertTitle != "") {
                  Navigator.of(context).pop();
                }
              },
            ),
            new FlatButton(
              child: new Text("CANCEL"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void tabTapped(int index) {
    setState(() {
      pageController.animateToPage(index,
          duration: Duration(milliseconds: 100), curve: Curves.easeOut);
    });
  }

  void pageChanged(int index) {
    setState(() {
      currentTab = index;
      if (currentTab == 1) {
        title = "Schedule";
        currentTabButton = null;
      } else if (currentTab == 2) {
        title = "Chat";
        currentTabButton = null;
      } else if (currentTab == 3) {
        title = "Settings";
        currentTabButton = null;
      } else {
        title = "VC DECA";
        currentTabButton = newAlertButton;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    pageController = new PageController();
    if (role == "admin") {
      currentButton = currentTabButton;
    }
    else {
      currentButton = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlue,
          title: new Text(title),
          textTheme: TextTheme(
            title: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold
            )
          ),
        ),
        floatingActionButton: currentTabButton,
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: currentTab,
          onTap: tabTapped,
          items: [
            new BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.home), title: Text("Home")),
            new BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.collections),
                title: Text("Schedule")),
            new BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.conversation_bubble),
                title: Text("Chat")),
            new BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.settings), title: Text("Settings")),
          ],
        ),
        drawer: Drawer(
          child: UserDrawer(),
        ),
        body: new Container(
          color: Colors.white,
          child: new PageView(
            onPageChanged: pageChanged,
            controller: pageController,
            children: <Widget>[
              HomePage(),
              SchedulePage(),
              ChatPage(),
              SettingsPage()
            ],
          ),
        ));
  }
}
