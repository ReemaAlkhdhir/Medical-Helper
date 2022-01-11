import 'package:connect_to_database/HomeNurse.dart';
import 'package:connect_to_database/HomePatient.dart';
import 'package:connect_to_database/HomePharm.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'home.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String UserType = "";
  String dropdownvalue = 'Doctor';
  var items = ['Doctor', 'Nurse', 'Pharmacist', 'Patient'];
  final database = FirebaseDatabase.instance.reference();
  final First_NameController = TextEditingController();
  final Last_NameController = TextEditingController();
  final EmailController = TextEditingController();
  final PhoneController = TextEditingController();
  final PassController = TextEditingController();

  get prefixIcon => null;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    First_NameController.dispose();
    Last_NameController.dispose();
    EmailController.dispose();
    PassController.dispose();
    PhoneController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    final userData = database.child('Users/');
    String PhoneNumber;
    return Scaffold(
      appBar: AppBar(
        title: Text("Medical Helper"),
        backgroundColor: Theme.of(context).accentColor,
        elevation: 2.0,
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
        child: MaterialButton(
          onPressed: () {
            Navigator.popUntil(
                context, ModalRoute.withName(Navigator.defaultRouteName));
          },
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                DropdownButtonFormField(
                  value: dropdownvalue,
                  icon: Icon(Icons.arrow_downward),
                  decoration: InputDecoration(
                    labelText: "Select Occupation",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  items: items.map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) async {
                    setState(() {
                      dropdownvalue = newValue as String;
                    });
                  },
                ),
                SizedBox(height: 10.0),
                TextField(
                  controller: First_NameController,
                  decoration: new InputDecoration(
                    prefixIcon: prefixIcon ?? Icon(Icons.person),
                    labelText: "FirstName...",
                    enabledBorder: const OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                TextField(
                  controller: Last_NameController,
                  decoration: new InputDecoration(
                    prefixIcon: prefixIcon ?? Icon(Icons.person),
                    labelText: "LastName...",
                    enabledBorder: const OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                TextField(
                  controller: EmailController,
                  decoration: new InputDecoration(
                    prefixIcon: prefixIcon ?? Icon(Icons.email),
                    labelText: "Example@gmail.com...",
                    enabledBorder: const OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                TextField(
                  controller: PhoneController,
                  decoration: new InputDecoration(
                    prefixIcon: prefixIcon ?? Icon(Icons.phone),
                    labelText: "05xxxxxxxxx",
                    enabledBorder: const OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                TextField(
                  controller: PassController,
                  decoration: new InputDecoration(
                    prefixIcon: prefixIcon ?? Icon(Icons.lock),
                    labelText: "Password...",
                    enabledBorder: const OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 25,
                  ),
                  child: MaterialButton(
                    onPressed: () {Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomeNurse()),
                    );},
                    /*async {
                      try {
                        PhoneNumber = PhoneController.text;
                        await userData.update({
                          PhoneNumber + '/First_Name':
                              First_NameController.text,
                          PhoneNumber + '/Last_Name': Last_NameController.text,
                          PhoneNumber + '/Email': EmailController.text,
                          PhoneNumber + '/Phone': PhoneController.text,
                          PhoneNumber + '/Password': PassController.text,
                          PhoneNumber + '/UserType': dropdownvalue,
                        });

                        print("Good way to set values");
                      } catch (e) {
                        print("You got an Error! $e");
                      }
                      if (dropdownvalue == 'Doctor' &&
                          First_NameController == "" &&
                          Last_NameController == "" &&
                          EmailController == "" &&
                          PhoneController == "" &&
                          PassController == "")
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      else if (dropdownvalue == 'Nurse' &&
                          First_NameController == "" &&
                          Last_NameController == "" &&
                          EmailController == "" &&
                          PhoneController == "" &&
                          PassController == "")
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomeNurse()),
                        );
                      else if (dropdownvalue == 'Pharmacist' &&
                          First_NameController == "" &&
                          Last_NameController == "" &&
                          EmailController == "" &&
                          PhoneController == "" &&
                          PassController == "")
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePharm()),
                        );
                      else if (dropdownvalue == 'Patient' &&
                          First_NameController == "" &&
                          Last_NameController == "" &&
                          EmailController == "" &&
                          PhoneController == "" &&
                          PassController == "")
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomePatient()),
                        );
                      else
                        Alert(context: context, title: "RFLUTTER", desc: "Invalid Data Please check your Data and try again").show();
                      print("skjkn");
                    },*/
                    minWidth: 250,
                    splashColor: Colors.green,
                    color: Colors.lightBlueAccent,
                    padding: EdgeInsets.symmetric(
                      vertical: 12,
                    ),
                    child: Text(
                      'Signup',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}

/*DropdownButton<String>(

                  value: dropdownvalue,
                  icon: Icon(Icons.keyboard_arrow_down_rounded),
                  hint: Text('Please choose the occupation '),
                  items: items.map((String items) {
                    return DropdownMenuItem<String>(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: (newValue) async {
                    setState(() {

                      dropdownvalue = newValue as String;
                    });
                  },
                ),*/
/* TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: 'Contains uppercase letters',
                    labelText: 'FristName *',
                  ,

                ),
                TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: 'Contains uppercase letters',
                    labelText: 'LastName *',
                  ),
                ),*/
