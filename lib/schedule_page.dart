import 'package:flutter/material.dart';
import 'package:vc_deca/user_info.dart';
import 'package:firebase_database/firebase_database.dart';

class SchedulePage extends StatefulWidget {
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class EventEntry {
  String key;
  String eventBody;

  EventEntry(this.eventBody);

  EventEntry.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        eventBody = snapshot.value["body"].toString();
}

class _SchedulePageState extends State<SchedulePage> {

  final databaseRef = FirebaseDatabase.instance.reference();

  List<EventEntry> eventList = new List();

  _SchedulePageState() {
    databaseRef.child("events").child(selectedYear).onChildAdded.listen(onEventAdded);
  }

  onEventAdded(Event event) {
    setState(() {
      eventList.add(new EventEntry.fromSnapshot(event.snapshot));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: new ListView.builder(
        itemCount: eventList.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              selectedEventCategory = eventList[index].key;
              print(selectedEventCategory);
              Navigator.of(context).pushNamed('/event');
            },
            child: new Card(
              child: new Container(
                padding: EdgeInsets.all(16.0),
                child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Container(
                      child: new Icon(
                        Icons.event_note,
                        color: Colors.lightBlue,
                      )
                  ),
                  new Padding(padding: EdgeInsets.all(5.0)),
                  new Column(
                    children: <Widget>[
                      new Container(
                        width: MediaQuery.of(context).size.width - 150,
                        child: new Text(
                          eventList[index].key,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      new Padding(padding: EdgeInsets.all(5.0)),
                      new Container(
                        width: MediaQuery.of(context).size.width - 150,
                        child: new Text(
                          eventList[index].eventBody,
                          textAlign: TextAlign.start,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 15.0,
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
    );
  }
}
