import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Rate.dart';
import 'StockDoctor.dart';
import 'TrackDoctor.dart';
import 'home.dart';
import 'main.dart';
import 'package:json_table/json_table.dart';

class StockNurse extends StatefulWidget {
  @override
  _StockNurseState createState() => _StockNurseState();
}

class _StockNurseState extends State<StockNurse> {
  final String jsonSample =
      '[{"RFID_tag":"12345","Company_Name":"Reema","Equipment_SerialNum":"1234","Equipment_Name":"AAA","Quantity_Num":"55"}]';

  bool toggle = true;

  final textcontroller = TextEditingController();
  final Password = TextEditingController();
  final databaseRef =
  FirebaseDatabase.instance.reference().child("RFID"); //.child("RFID");
  final Future<FirebaseApp> _future = Firebase.initializeApp();

  get prefixIcon => null;

  void addData(String Username) {
    databaseRef
        .push()
        .set({'RFID_ID': Username, 'RFID_info': 'in', 'RFID_tag': 124});
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
        title: Text("Stock"),
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
                    rowHighlightColor:
                    Colors.yellow[500]!.withOpacity(0.7),
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
      ]),
    );
  }

  String getPrettyJSONString(jsonObject) {
    JsonEncoder encoder = new JsonEncoder.withIndent('  ');
    String jsonString = encoder.convert(json.decode(jsonObject));
    return jsonString;
  }
}
