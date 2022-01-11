import 'dart:convert';
import 'package:flutter/material.dart';
import 'Rate.dart';
import 'TrackDoctor.dart';
import 'main.dart';
import 'package:json_table/json_table.dart';
import 'package:firebase_database/firebase_database.dart';

class StockDoctor extends StatefulWidget {
  @override
  _StockDoctorState createState() => _StockDoctorState();
}

class _StockDoctorState extends State<StockDoctor> {

  // code that might throw an exception

String displayText="Results appear hear";
  final _database=FirebaseDatabase.instance.reference();

  static var  EquipmentData="";

  final Equipment =TextEditingController(text: '1');
  String userID ="";
  @override
  void initState(){
    _activateListeners();
    getUserAmount();
    super.initState();
  }

  final String jsonSample = EquipmentData;
 //'[{"Availability":"yes","Company_name":"ACCU-CHEK","RFID_tag":"e65500","equipment_name":"blood glucose meter","equipment_serialNum":"968488","quantity_num":"50"},{"Availability":"yes","Company_name":"OMRON","RFID_tag":"e64532","equipment_name":"pressure measurement","equipment_serialNum":"989778","quantity_num":"55"},{"Availability":"yes or no","Company_name":"CITIZEN","RFID_tag":"e32324","equipments_name":"Thermal Measurement","equipments_serialNum":"64647577","quantity_num":"50"}]';
// '[{"Availability":"yes","Company_name":"ACCU-CHEK","RFID_tag":"e65500","equipment_name":"blood glucose meter","equipment_serialNum":"968488","quantity_num":"50"},'
  // '[{"Equipment_Name": "ACCU-CHEK","Equipment_SerialNum":"968488456","Quantity_Num":"55","Availability":"Yes"},'
     // '{"Availability":"yes or no","RFID_tag":"674984","company_name":"OMRON","equipment_serialName":"456737475","equipments_name":"pressure measurement","quantity_num":"55"},'

     // '{"Availability":"yes or no","RFID_TAG":"845027","company_name":"CITIZEN","equipments_name":"Thermal Measurement","equipments_serialNum":"64647577","quantity_num":"50"}]';


    //'[{"Equipment_Name": "ACCU-CHEK","Equipment_SerialNum":"968488456","Quantity_Num":"55","Availability":"Yes"},'
  //    '{"Equipment_Name":"OMRON","Equipment_SerialNum":"456737475","Quantity_Num":"43","Availability":"No"}]';

  bool toggle = true;

  get prefixIcon => null;

  void _activateListeners()  {
    _database.child('Users/05055511122/Email').onValue.listen((event)
    {final String Email= event.snapshot.value;
    setState(() {
      displayText="The value of email from database is: $Email";
    });
    });
    getUserAmount();
  }
  /*
  void _activateListeners()
  {
    //_database.orderByChild('Users/').startAt(PhoneController).onValue.listen((event) { });
    // _database.orderByChild('Users/').startAt(PhoneController).onValue.listen((event)
    _database.child('Equipments').child(Equipment.text).orderByChild('equipment_name').onChildAdded.listen((event)
    // _database.orderByChild('Users/').equalTo(PhoneController)
    { userID= event.snapshot.value;
    setState(() {
      displayText="The value of email from database is: $userID";
    });
    });
  }*/
  static Future<int> getUserAmount() async {
    final response= await FirebaseDatabase.instance.reference().child("Equipments/").once();
    var users=[];
    var Equipment="[";
    response.value.forEach((key,values)  => users.add(key));
    print (users);
    int count=0;
    var names=[], data=[];
    for(int i=0; i<users.length;i++) {
      final response1 = await FirebaseDatabase.instance.reference().child(
          "Equipments/" + users[i] + "/").once();
      response1.value.forEach((key,values)  => names.add(key));
      response1.value.forEach((key,values)  => data.add(values));}
    for(int i=0; i<names.length;i++) {
      if(i%6==0)
      {Equipment +="{"; count++;}
      if(i!=count*6-1)
        Equipment += '"'+names[i]+'":"'+data[i]+'",' ;
      // if(i==6 )
      //   Equipment +="}";
      if(i==count*6-1 && i!=names.length-1)
        Equipment +='"'+names[i]+'":"'+data[i]+'"},';
      if(i==count*6-1 && i==names.length-1)
        Equipment += '"'+names[i]+'":"'+data[i]+'"}';
    }
    Equipment+="]";
    EquipmentData=Equipment;
    print (Equipment);
    return users.length;
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
        Column(children:  <Widget>[
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
        ]
        ),
      ]
      ),
    );
  }

  String getPrettyJSONString(jsonObject) {
    _activateListeners();
    JsonEncoder encoder = new JsonEncoder.withIndent('  ');
    String jsonString = encoder.convert(json.decode(jsonObject));
    return jsonString;
  }
}












