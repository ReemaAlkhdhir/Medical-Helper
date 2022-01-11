import 'package:connect_to_database/StockPharm.dart';
import 'package:connect_to_database/TrackPharm.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Rate.dart';
import 'StockDoctor.dart';
import 'TrackDoctor.dart';
import 'main.dart';

class HomePharm extends StatefulWidget {
  @override
  _HomePharmState createState() => _HomePharmState();
}

class _HomePharmState extends State<HomePharm> {
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
        title: Text("Medical Helper"),
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

      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset('assets/images/medical.jpeg',width: 300,
              height: 300,
              scale: 0.10
          ),
          MaterialButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => StockPharm()),
              );
            },
            minWidth: 200,
            splashColor: Colors.green,
            color: Colors.lightBlueAccent,
            padding: EdgeInsets.symmetric(
              vertical: 12,
            ),
            child: Text(
              'Stock',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
          SizedBox(height: 10.0),
          MaterialButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TrackPharm()),
              );
            },
            minWidth: 200,
            splashColor: Colors.green,
            color: Colors.lightBlueAccent,
            padding: EdgeInsets.symmetric(
              vertical: 12,
            ),
            child: Text(
              'Track',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
          SizedBox(height: 10.0),
          MaterialButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Rate()),
              );
            },
            minWidth: 200,
            splashColor: Colors.green,
            color: Colors.lightBlueAccent,
            padding: EdgeInsets.symmetric(
              vertical: 12,
            ),
            child: Text(
              'Rate',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
              ),
            ),
          ),
          SizedBox(height: 10.0),
          MaterialButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyApp()),
              );
            },
            minWidth: 200,
            splashColor: Colors.green,
            color: Colors.lightBlueAccent,
            padding: EdgeInsets.symmetric(
              vertical: 12,
            ),
            child: Text(
              'Log out',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}