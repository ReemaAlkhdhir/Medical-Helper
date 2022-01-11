import 'package:flutter/material.dart';
import 'Rate.dart';
import 'StockDoctor.dart';
import 'TrackDoctor.dart';
import 'main.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

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
                MaterialPageRoute(builder: (context) => StockDoctor()),
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
                MaterialPageRoute(builder: (context) => TrackDoctor()),
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
/*
    return Scaffold(
      appBar: AppBar(title: Text("Firebase Demo"),),
      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(height: 250.0),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: TextField(controller: textcontroller),
            ),
            SizedBox(height: 30.0),
            Center(
                child: RaisedButton(
                    color: Colors.pinkAccent,
                    child: Text("Save to Database"),
                    onPressed: () {
                      addData(textcontroller.text);
                      //call method flutter upload
                    }
                )
            ),
          ],
        ),
      ),);  // add scaffold here
  }
}
*/
