import 'package:flutter/material.dart';
import 'package:vc_deca/user_info.dart';
import 'package:firebase_database/firebase_database.dart';

class EventPage extends StatefulWidget {
  @override
  _EventPageState createState() => _EventPageState();
}

class EventListing {
  String key;
  String eventTime;
  String eventPerson;

  EventListing(this.eventTime, this.eventPerson);

  EventListing.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        eventTime = snapshot.value["time"].toString(),
        eventPerson = snapshot.value["name"].toString();
}

class _EventPageState extends State<EventPage> {

  final databaseRef = FirebaseDatabase.instance.reference();
  List<EventListing> eventList = new List();

  String categoryShort = "";
  String categoryTitle = "";
  String categoryBody = "";
  String eventLocation = "";

  _EventPageState() {
    databaseRef.child("events").child(selectedCategory).child(selectedEvent).once().then((DataSnapshot snapshot) {
      print(snapshot.value);
      categoryTitle = snapshot.key;
      var categoryInfo = snapshot.value;
      setState(() {
        categoryShort = categoryInfo["short"];
        categoryBody = categoryInfo["body"];
        eventLocation = categoryInfo["location"];
      });
    });
    databaseRef.child("events").child(selectedCategory).child(selectedEvent).child("events").onChildAdded.listen(onEventAdded);
  }

  onEventAdded(Event event) {
    setState(() {
      eventList.add(new EventListing.fromSnapshot(event.snapshot));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: new Text(categoryShort),
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
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text(
                categoryTitle,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                ),
                textAlign: TextAlign.left,
              ),
              new Padding(padding: EdgeInsets.all(8.0)),
              new Text(
                eventLocation,
                style: TextStyle(
                  color: Colors.lightBlue,
                  fontWeight: FontWeight.normal,
                  fontStyle: FontStyle.italic,
                  fontSize: 17.0,
                ),
              ),
              new Padding(padding: EdgeInsets.all(8.0)),
              new Text(
                categoryBody,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 17.0,
                ),
              ),
              new Divider(
                color: Colors.lightBlue,
                height: 20.0,
              ),
              new Text(
                "Event Schedule:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17.0,
                ),
              ),
              new Padding(padding: EdgeInsets.all(0.0)),
              new Expanded(
                child: new Stack(
                  children: <Widget>[
                    new Container(
                      height: 50.0,
                      child: new Center(
                        child: new Text(
                          "Nothing to see here!\nCheck back later for event time listings.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.lightBlue,
                            fontSize: 12.0,
                          ),
                        ),
                      )
                    ),
                    new ListView.builder(
                      itemCount: eventList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                          },
                          child: new Card(
                            child: new Container(
                              padding: EdgeInsets.all(16.0),
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  new Container(
                                      child: new Text(
                                        eventList[index].eventTime,
                                        style: TextStyle(color: Colors.lightBlue, fontSize: 17.0, fontWeight: FontWeight.bold),
                                      )
                                  ),
                                  new Padding(padding: EdgeInsets.all(5.0)),
                                  new Column(
                                    children: <Widget>[
                                      new Container(
                                        width: MediaQuery.of(context).size.width - 185,
                                        child: new Text(
                                          eventList[index].eventPerson,
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontSize: 17.0,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  new Padding(padding: EdgeInsets.all(5.0)),
                                  new Container(
                                      child: new Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.lightBlue,
                                      )
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                )
              )
            ],
          ),
      ),
    );
  }
}
