import 'package:flutter/material.dart';

class EventPage extends StatefulWidget {
  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: new Text("Details"),
        textTheme: TextTheme(
            title: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold
            )
        ),
      ),
      body: new Container(
          padding: EdgeInsets.all(16.0),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: new SingleChildScrollView(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(
                  "Event Name",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                  ),
                  textAlign: TextAlign.left,
                ),
                new Padding(padding: EdgeInsets.all(8.0)),
                new Text(
                  "Event Time",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontStyle: FontStyle.italic,
                    color: Colors.lightBlue,
                    fontSize: 15.0,
                  ),
                ),
                new Padding(padding: EdgeInsets.all(8.0)),
                new Text(
                  "Event Location",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontStyle: FontStyle.italic,
                    color: Colors.lightBlue,
                    fontSize: 15.0,
                  ),
                ),
                new Padding(padding: EdgeInsets.all(8.0)),
                new Text(
                  "Event Description",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 17.0,
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
}
