import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'home.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
   static String dropdownvalue = 'Doctor';
  var items = ['Doctor', 'Nurse', 'Pharmacist', 'Patient'];
  final PhoneController = TextEditingController();
  static String  phoneNumber = " ";
  static bool userIDisCorrect = false;
  String userID = " ";final _database = FirebaseDatabase.instance.reference();
 // String Type = " ";
  //String displayText = "Results appear hear";
  //String displayType = "Results appear hear";

  @override
  void initState() {
    super.initState();
    getUserAmount();
    _activateListeners();

    //_TypeListeners();
  }

  static Future<int> getUserAmount() async {
    final response= await FirebaseDatabase.instance.reference().child("Users/").once();
    var users=[];
    response.value.forEach((key,values)  => users.add(key));
    print (users);
    int count=0;
    var names=[], data=[];
    for(int i=0; i<users.length;i++) {
     // if (users[i] == phoneNumber)
      final response1 = await FirebaseDatabase.instance.reference().child(
          "Users/" + users[i] + "/").once();
      response1.value.forEach((key,values)  => names.add(key));
      response1.value.forEach((key,values)  => data.add(values));}
    for(int i=0; i<users.length;i++) {
      if (users[i] == phoneNumber) {
        print(users[i]);
        for (int j = 0; j < names.length; j++)
          if (names[j] == "UserType")
            if (data[j] == dropdownvalue) {
              userIDisCorrect = true;
              print(names[j] + data[j]);
            }
      }
    }
print (">>>>>>>>>>>>>>>>>>>>>>>>>>>.");
    return users.length;
  }

  void _activateListeners() {
    //_database.orderByChild('Users/').startAt(PhoneController).onValue.listen((event) { });
    // _database.orderByChild('Users/').startAt(PhoneController).onValue.listen((event)
    _database
        .child('Users')
        .child(PhoneController.text)
        .orderByChild('Email')
        .onChildAdded
        .listen((event)
            // _database.orderByChild('Users/').equalTo(PhoneController)
            {
       userID = event.snapshot.value;
      setState(() {
       // displayText = "The value of email from database is: $userID";
      });
    });
  }


/*
  void _TypeListeners() {
    //_database.orderByChild('Users/').startAt(PhoneController).onValue.listen((event) { });
    // _database.orderByChild('Users/').startAt(PhoneController).onValue.listen((event)
    _database
        .child('Users')
        .child(PhoneController.text)
        .orderByChild('UserType')
        .onChildAdded
        .listen((event) {
      Type = event.snapshot.value;
      setState(() {
        displayType = "The value of email from database is: $Type";
      });
    });
  }
*/
  get prefixIcon => null;

  @override
  Widget build(BuildContext context) {
    // final password =database.child('password/');
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
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: TextField(
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
                        setState(() {});
                      }),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: TextField(
                    decoration: new InputDecoration(
                      prefixIcon: prefixIcon ?? Icon(Icons.lock),
                      labelText: "Password...",
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
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 25,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forget Password',
                        style: TextStyle(
                          color: Colors.lightBlueAccent,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                /*Text(displayText,
                    style: const TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center),*/
                MaterialButton(

                  onPressed: () {
                    phoneNumber = PhoneController.text;
                    if (userIDisCorrect == false) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    }
                    else
                   //   Alert(context: context, title: "RFLUTTER", desc: "Invalid Data").show();
                      print("Login Successfully");
                  },

                  minWidth: 250,
                  splashColor: Colors.green,
                  color: Colors.lightBlueAccent,
                  padding: EdgeInsets.symmetric(
                    vertical: 12,
                  ),
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
                /*RaisedButton(
                  color: Colors.lightBlueAccent,
                  padding: EdgeInsets.symmetric(
                    vertical: 12,
                  ),
                  child: Text("Login",
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                  //onPressed: (){},
                  onPressed: () {
                    _activateListeners();
                    if (PhoneController.text == userID) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    } else
                      print("Invalid username");
                  },*/
                /* if (EmailController == _database.child('Users/05055511122/Email').onValue) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    }
                    else
                      print("Invalid username");
                  },
                ),*/
                /*  if (databaseRef.orderByChild("Username").equalTo(Username).once().toString() == Username.toString()){
                      //Alert(message: 'Test', shortDuration: true).show();
                      //Alert(context: context, title: "RFLUTTER", desc: "databaseRef.orderByChild('Username').equalTo(Username).once().toString()").show();

                       Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                      );}
                      else{
                       Alert(context: context, title: "RFLUTTER", desc: "Invalid username").show();

                     }
                      //call method flutter upload
                    }*/
              ]),
        ),
      ),
    );
  }
}
