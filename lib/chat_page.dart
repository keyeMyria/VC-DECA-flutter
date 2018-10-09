import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      color: Colors.white,
      child: new Column(
        children: <Widget>[
          new ListTile(
            title: Text("Global Chat"),
            onTap: () {
              print("Entering Global Chat");
              Navigator.of(context).pushNamed('/globalChat');
            },
            trailing: new Icon(
              Icons.arrow_forward_ios,
              color: Colors.lightBlue,
            ),
          ),
          new Divider(
            height: 0.0,
            color: Colors.lightBlue,
          ),
          new ListTile(
            title: Text("Chapherone Group Chat"),
            onTap: () {
              print("Entering Chaperone Chat");
            },
            trailing: new Icon(
              Icons.arrow_forward_ios,
              color: Colors.lightBlue,
            ),
          )
        ],
      ),
    );
  }
}
