import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';

import 'Rate.dart';
import 'package:flutter_simple_rating_bar/flutter_simple_rating_bar.dart';

import 'StockDoctor.dart';
import 'TrackDoctor.dart';
import 'main.dart';

class Rate extends StatefulWidget {
  @override
  _RateState createState() => _RateState();
}

class _RateState extends State<Rate> {
  final textcontroller = TextEditingController();
  final databaseRef = FirebaseDatabase.instance
      .reference()
      .child("medical-helper-a92cb-default-rtdb"); //.child("RFID");
  final Future<FirebaseApp> _future = Firebase.initializeApp();

  void addData(String data) {
    databaseRef
        .push()
        .set({'RFID_ID': data, 'RFID_INFO': 'A good season', 'RFID_tag': '55'});
  }

  void printFirebase() {
    databaseRef.once().then((DataSnapshot snapshot) {
      print('Data : ${snapshot.value}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rate"),
        backgroundColor: Theme.of(context).accentColor,
        elevation: 3.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: Column(children: [
        Row(children: [
          FlatButton(
            child: Text(
              'Rate',
              style: TextStyle(fontSize: 20.0),
            ),
            // color: Colors.cyan,
            textColor: Colors.black,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Rate()),
              );
            },
          ),
          FlatButton(
            child: Text(
              'Stock',
              style: TextStyle(fontSize: 20.0),
            ),
            // color: Colors.cyan,
            textColor: Colors.black,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => StockDoctor()),
              );
            },
          ),
          FlatButton(
            child: Text(
              'Track',
              style: TextStyle(fontSize: 20.0),
            ),
            // color: Colors.cyan,
            textColor: Colors.black,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TrackDoctor()),
              );
            },
          ),
          FlatButton(
            child: Text(
              'Log out',
              style: TextStyle(fontSize: 20.0),
            ),
            // color: Colors.cyan,
            textColor: Colors.black,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyApp()),
              );
            },
          ),
        ]),
        SizedBox(height: 30.0),
        Column(
          children: [
            Text(
              'How satisfied are you with the service?',
              style: TextStyle(fontSize: 20.0),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 40),
              child: RatingBar(
                rating: 3,
                icon: Icon(Icons.stars, size: 45, color: Colors.grey),
                starCount: 5,
                spacing: 5.0,
                size: 45,
                isIndicator: false,
                allowHalfRating: true,
                onRatingCallback: (value, notifier) {
                  //isIndicator:=true, so you dont need to  care this.
                },
                color: Colors.amber,
              ),
            ),
            SizedBox(height: 30.0),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                decoration: new InputDecoration(
                  icon: new Icon(Icons.chat_outlined),
                  labelText: "Write your comment about the service provided...",
                  //contentPadding: const EdgeInsets.symmetric(vertical: 40.0),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
