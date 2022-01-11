import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ReadExample extends StatefulWidget{
  @override
  _ReadExampleState createState() => _ReadExampleState();

}

class  _ReadExampleState extends State<ReadExample>
{
 // final _database=FirebaseDatabase.instance.reference();
  String displayText="Results appear hear";
  final PhoneController = TextEditingController();
  String userID = " ";final _database = FirebaseDatabase.instance.reference();

  get prefixIcon => null;

  @override
  void initState(){
    super.initState();
    _activateListeners();
  }

 /* void _activateListeners(){
    _database.child('Users/').onValue.listen((event)
  //  _database.orderByChild('Users/').startAt("0598050868").once()
    {final String Email= event.snapshot.value;
    setState(() {
      displayText="The value of email from database is: $Email";
    });
    });
  }
  */
  void _activateListeners() {
    //_database.orderByChild('Users/').startAt(PhoneController).onValue.listen((event) { });
    // _database.orderByChild('Users/').startAt(PhoneController).onValue.listen((event)
    _database
        .child('Users')
        .child(PhoneController.text)
        .orderByChild('Phone')
        .onChildAdded
        .listen((event)
    // _database.orderByChild('Users/').equalTo(PhoneController)
    {
      userID = event.snapshot.value;
      setState(() {
        displayText = "The value of email from database is: $userID";
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar (title: const Text('Read Examples'), ),
        body: Center(
            child: Padding(
                padding: const EdgeInsets.only(top:15.0),
                child: Column (
                  children: [
                    TextField(
                        controller: PhoneController,
                        decoration: new InputDecoration(
                          prefixIcon: prefixIcon ?? Icon(Icons.person),
                          labelText: "Enter yor Phone Number ...",
                          enabledBorder: const OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                        ),
                        onChanged: (val) {
                          setState(() {
                            displayText = "The value of email from database is: $userID";
                          });
                        }),
                    Text(displayText,
                    style:const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center),
                  ],

                )
            )
        )
    );
  }
}