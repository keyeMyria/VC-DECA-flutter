import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:vc_deca/home_page.dart';
import 'package:vc_deca/setting_page.dart';
import 'package:vc_deca/schedule_page.dart';
import 'package:vc_deca/chat_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TabBarController extends StatefulWidget {
  @override
  _TabBarControllerState createState() => _TabBarControllerState();
}

class _TabBarControllerState extends State<TabBarController> {

  PageController pageController;
  int currentTab = 0;

  void tabTapped(int index) {
    setState(() {
      currentTab = index;
      pageController.animateToPage(index, duration: Duration(milliseconds: 100), curve: Curves.easeOut);
    });
  }

  void pageChanged(int index) {
    setState(() {
      currentTab = index;
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
        title: new Text("VC DECA"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentTab,
        onTap: tabTapped,
        items: [
          new BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), title: Text("Home")),
          new BottomNavigationBarItem(icon: Icon(CupertinoIcons.collections), title: Text("Schedule")),
          new BottomNavigationBarItem(icon: Icon(CupertinoIcons.conversation_bubble), title: Text("Chat")),
          new BottomNavigationBarItem(icon: Icon(CupertinoIcons.settings), title: Text("Settings")),
        ],
      ),
      drawer: Drawer(
        child: new Center(
          child: new Column(
            children: <Widget>[
            ],
          ),
        ),
      ),
      body: new PageView(
        onPageChanged: pageChanged,
        controller: pageController,
        children: <Widget>[
          HomePage(),
          SchedulePage(),
          ChatPage(),
          SettingsPage()
        ],
      ),
    );
  }
}
