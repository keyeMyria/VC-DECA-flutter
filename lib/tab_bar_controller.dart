import 'dart:async';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:vc_deca/home_page.dart';
import 'package:vc_deca/setting_page.dart';
import 'package:vc_deca/schedule_page.dart';
import 'package:vc_deca/chat_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:vc_deca/user_drawer.dart';
import 'package:vc_deca/user_info.dart';

class TabBarController extends StatefulWidget {
  @override
  _TabBarControllerState createState() => _TabBarControllerState();
}

class _TabBarControllerState extends State<TabBarController> {

  final databaseRef = FirebaseDatabase.instance.reference();

  String title = "VC DECA";

  PageController pageController;
  int currentTab = 0;

  var currentTabButton;
  var currentButton;

  var newAlertTitle = "";
  var newAlertBody = "";

  var newGroupCode = "";
  var newChaperoneName = "";

  void alertTitleText(String input) {
    setState(() {
      newAlertTitle = input;
    });
  }

  void alertBodyText(String input) {
    setState(() {
      newAlertBody = input;
    });
  }

  void addAlertDialog() {
    newAlertBody = "";
    newAlertTitle = "";
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Create New Announcement"),
          content: new Container(
            height: 150.0,
            child: new Column(
              children: <Widget>[
                new TextField(
                  onChanged: alertTitleText,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                      labelText: "Announcement Title",
                      hintText: "Enter announcement title"
                  ),
                ),
                new TextField(
                  onChanged: alertBodyText,
                  maxLines: null,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                      labelText: "Announcement Body",
                      hintText: "Enter announcement body"
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text("CREATE"),
              onPressed: () {
                if (newAlertTitle != "" && newAlertBody != "") {
                  databaseRef.child("alerts").push().update({
                    "title": newAlertTitle,
                    "body": newAlertBody,
                    "date": formatDate(DateTime.now(), [dd, '/', mm, '/', yyyy, ' ', HH, ':', nn])
                  });
                  newAlertBody = "";
                  newAlertTitle = "";
                  Navigator.of(context).pop();
                }
              },
            ),
            new FlatButton(
              child: new Text("CANCEL"),
              onPressed: () {
                newAlertBody = "";
                newAlertTitle = "";
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void createGroupDialog() {
    newGroupCode = "";
    newChaperoneName = "";
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Create Chaperone Group"),
          content: new Container(
            height: 150.0,
            child: new Column(
              children: <Widget>[
                new TextField(
                  onChanged: (String input) {
                    newChaperoneName = input;
                  },
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                      labelText: "Chaperone Name",
                      hintText: "Enter chaperone's name"
                  ),
                ),
                new Padding(padding: EdgeInsets.all(5.0)),
                new TextField(
                  onChanged: (String input) {
                    newGroupCode = input;
                  },
                  textCapitalization: TextCapitalization.characters,
                  decoration: InputDecoration(
                      labelText: "Group Code",
                      hintText: "Enter chaperone group code"
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text("CREATE"),
              onPressed: () {
                if (newGroupCode != "" && newChaperoneName != "") {
                  databaseRef.child("chat").child(newGroupCode).push().update({
                    "author": "GroupCreatorBot",
                    "message": "Welcome to $newChaperoneName's chaperone group!"
                  });
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
        if (role == "admin") {
          currentButton = currentTabButton;
        }
      } else if (currentTab == 2) {
        title = "Chat";
        currentTabButton = null;
        currentTabButton = new FloatingActionButton(
          backgroundColor: Colors.lightBlue,
          child: Icon(Icons.group_add),
          onPressed: createGroupDialog,
        );
        if (role == "admin") {
          currentButton = currentTabButton;
        }
      } else if (currentTab == 3) {
        title = "Settings";
        currentTabButton = null;
        if (role == "admin") {
          currentButton = currentTabButton;
        }
      } else {
        title = "VC DECA";
        currentTabButton = new FloatingActionButton(
          backgroundColor: Colors.lightBlue,
          child: Icon(Icons.add),
          onPressed: addAlertDialog,
        );
        if (role == "admin") {
          currentButton = currentTabButton;
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    pageController = new PageController();
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
        floatingActionButton: currentButton,
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
