import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Rate.dart';
import 'package:json_table/json_table.dart';

import 'StockDoctor.dart';
import 'main.dart';

class TrackDoctor extends StatefulWidget {
  @override
  _TrackDoctorState createState() => _TrackDoctorState();
}

class _TrackDoctorState extends State<TrackDoctor> {
  final String jsonSample = EquipmentData;
  //[{"DoctorName":"Noura Mohhamed","Doctor_ID":"1515","Equipment_serialNum":"234567890","DoctorName":"Ahmed Khalid","Doctor_ID":"1313","Equipment_serialNum":"87654323456"},{"DoctorName":"Amerah","Doctor_ID":"1717","Equipment_serialNum":"123456789",]
  //'[{"DoctorName":"Noura Mohhamed","Doctor_ID":"1515","Equipment_serialNum":"234567890","DoctorName":"Ahmed Khalid","Doctor_ID":"1313","Equipment_serialNum":"87654323456"}]';
     //'[{"Equipment_SerialNum":"968488456","Nurse_Name":"Ana","Nurse_ID":"1111"}]';
  bool toggle = true;

  final textcontroller = TextEditingController();
  static var  EquipmentData="";

  final Equipment =TextEditingController();

  get prefixIcon => null;
  @override
  void initState(){
    getUserAmount();
    super.initState();
  }
  static Future<int> getUserAmount() async {
    final response= await FirebaseDatabase.instance.reference().child("DoctorEqipmentTable/").once();
    var users=[];
    var Equipment="[";
    response.value.forEach((key,values)  => users.add(key));
    print (users);
    int count=0;
    var names=[], data=[];
    for(int i=0; i<users.length;i++) {
      final response1 = await FirebaseDatabase.instance.reference().child(
          "DoctorEqipmentTable/" + users[i] + "/").once();
      response1.value.forEach((key,values)  => names.add(key));
      response1.value.forEach((key,values)  => data.add(values));}
    for(int i=0; i<names.length;i++) {
      if(i%3==0)
      {Equipment +="{"; count++;}
      if(i!=count*3-1)
        Equipment += '"'+names[i]+'":"'+data[i]+'",' ;
      // if(i==6 )
      //   Equipment +="}";
      if(i==count*3-1 && i!=names.length-1)
        Equipment +='"'+names[i]+'":"'+data[i]+'"},';
      if(i==count*3-1 && i==names.length-1)
        Equipment += '"'+names[i]+'":"'+data[i]+'"}';
    }
    Equipment+="]";
    // print (names.length);
    EquipmentData=Equipment;
    print (Equipment);
    return users.length;
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
