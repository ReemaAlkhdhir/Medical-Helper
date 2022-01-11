import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Rate.dart';
import 'package:json_table/json_table.dart';

import 'StockDoctor.dart';
import 'TrackDoctor.dart';
import 'main.dart';

class TrackPharm extends StatefulWidget {
  @override
  _TrackPharmState createState() => _TrackPharmState();
}

class _TrackPharmState extends State<TrackPharm> {
  final String jsonSample =
      '[{"Company_name":"pfizer","Code":"4358","Concentration":"150mg","Expiry_date":"26/3/2022","From":"Drugs","Production_date":"13/9/2021"}]';
  bool toggle = true;

  final textcontroller = TextEditingController();
  final databaseRef = FirebaseDatabase.instance
      .reference()
      .child("medical-helper-a92cb-default-rtdb"); //.child("RFID");
  final Future<FirebaseApp> _future = Firebase.initializeApp();

  get prefixIcon => null;

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
    var json = jsonDecode(jsonSample);
    return Scaffold(
      appBar: AppBar(
        title: Text("Track"),
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
        Column(children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextField(
              //controller: Username,
              decoration: new InputDecoration(
                prefixIcon: prefixIcon ?? Icon(Icons.search),
                labelText: "Search",
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
        ]),
        SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Container(
            child: toggle
                ? Column(
              children: [
                JsonTable(
                  json,
                  showColumnToggle: true,
                  allowRowHighlight: true,
                  rowHighlightColor: Colors.yellow[500]!.withOpacity(0.7),
                  paginationRowCount: 20,
                  onRowSelect: (index, map) {
                    print(index);
                    print(map);
                  },
                ),
              ],
            )
                : Center(
              child: Text(getPrettyJSONString(jsonSample)),
            ),
          ),
        ),
      ]),
    );
  }

  String getPrettyJSONString(jsonObject) {
    JsonEncoder encoder = new JsonEncoder.withIndent('  ');
    String jsonString = encoder.convert(json.decode(jsonObject));
    return jsonString;
  }
}
