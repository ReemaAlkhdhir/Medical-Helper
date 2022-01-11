import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class WriteExample extends StatefulWidget{
  @override
  _WriteExampleState createState() => _WriteExampleState();

}

class  _WriteExampleState extends State<WriteExample>
{
  final database=FirebaseDatabase.instance.reference();
  final First_NameController = TextEditingController();
  final Last_NameController= TextEditingController();
  final EmailController=TextEditingController();
  final PhoneController=TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    First_NameController.dispose();
    Last_NameController.dispose();
    EmailController.dispose();
    PhoneController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final userData=database.child('Users/');
    String PhoneNumber;
    return Scaffold(
    appBar: AppBar (title: const Text('Write Examples'), ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top:15.0),
          child: Column (
            children: [
              TextField(
                controller: First_NameController,
                  ),
              TextField(
                controller: Last_NameController,
              ),
              TextField(
                controller: EmailController,
              ),
              TextField(
                controller: PhoneController,

              ),

              ElevatedButton(
                onPressed:() async{
                  try{

                    PhoneNumber=PhoneController.text;
                  //  await userData.update({ 'UserID':PhoneNumber});
                    await userData.update({PhoneNumber+'/First_Name':First_NameController.text,
                     PhoneNumber+'/Last_Name':Last_NameController.text,
                      PhoneNumber+'/Email': EmailController.text,
                      PhoneNumber+'/Phone': PhoneController.text,
                    '05055511122/First_Name':'Reema', '05055511122/Last_Name':'Khudair', '05055511122/Email':'Reema_Nasser@gmail.com',
                    '05055511122/Phone':'05055511122',
                      '05044411122/First_Name':'Abeer', '05044411122/Last Name':'Alotiby', '05044411122/Email':'Abeer_Jazzy@gmail.com',
                  '05044411122/Phone':'05044411122', });
                       print("Good way to set values");

                } catch (e){print ("You got an Error! $e");}
               },
                child:const Text('Simple set'),
              ),
            ],

          )

        )
      )

    );

  }
}