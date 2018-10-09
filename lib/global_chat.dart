import 'package:flutter/material.dart';
import 'package:vc_deca/user_info.dart';
import 'package:firebase_database/firebase_database.dart';

class GlobalChatPage extends StatefulWidget {
  @override
  _GlobalChatPageState createState() => _GlobalChatPageState();
}

class ChatMessage {
  String key;
  String message;
  String author;

  ChatMessage(this.message, this.author);

  ChatMessage.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        message = snapshot.value["message"].toString(),
        author = snapshot.value["author"].toString();

  toJson() {
    return {
      "message": message,
      "author": author
    };
  }
}

class _GlobalChatPageState extends State<GlobalChatPage> {

  final databaseRef = FirebaseDatabase.instance.reference();
  List<ChatMessage> messageList = new List();

  String message = "";

  _GlobalChatPageState() {
    databaseRef.child("chat").child("global").onChildAdded.listen(onNewMessage);
  }

  onNewMessage(Event event) {
    setState(() {
      messageList.add(new ChatMessage.fromSnapshot(event.snapshot));
    });
  }

  onMessageDeletion(Event event) {
    var oldValue =
    messageList.singleWhere((entry) => entry.key == event.snapshot.key);
    setState(() {
      messageList.removeAt(messageList.indexOf(oldValue));
    });
  }

  void newMessage(String input) {
    message = input;
  }

  void sendMessage(String input) {
    if (message != "" && message != " ") {
      databaseRef.child("chat").child("global").push().update({
        "author": name,
        "message": input,
      });
    }

  }

  TextAlign getAlignment(String messageAuthor) {
    if (messageAuthor == name) {
      return TextAlign.end;
    }
    else {
      return TextAlign.start;
    }
  }

  Color getColor(String messageAuthor) {
    if (messageAuthor == name) {
      return Colors.lightBlue;
    }
    else {
      return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: new Text("Global Chat"),
        textTheme: TextTheme(
            title: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold
            )
        ),
      ),
      backgroundColor: Colors.white,
      floatingActionButton: new Container(
        padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 32.0),
        child: new TextField(
          textInputAction: TextInputAction.send,
          textCapitalization: TextCapitalization.sentences,
          onChanged: newMessage,
          onSubmitted: sendMessage,
          decoration: InputDecoration(
            labelText: "Enter Message"
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: new SafeArea(
        child: new Container(
          height: MediaQuery.of(context).size.height - 200,
          padding: EdgeInsets.all(16.0),
          child: new ListView.builder(
            shrinkWrap: true,
            itemCount: messageList.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                child: ListTile(
                  title: new Text(
                    messageList[index].message,
                    textAlign: getAlignment(messageList[index].author),
                    style: TextStyle(
                        color: getColor(messageList[index].author)
                    ),
                  ),
                  subtitle: new Text(
                    messageList[index].author,
                    textAlign: getAlignment(messageList[index].author),
                    style: TextStyle(
//                    color: getColor(messageList[index].author)
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
