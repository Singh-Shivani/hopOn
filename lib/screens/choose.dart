import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'select_car.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'give_vehicle/map.dart';
import '../widgets/widgets.dart';

class ChooseOption extends StatelessWidget {
  static const String _title = 'Select an option';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(_title),
          backgroundColor: Colors.black,
        ),
        drawer: Container(
          width: 250,
          color: Colors.white,
          child: DrawerList(),
        ),
        body: MyChoice(),
      ),
    );
  }
}


class MyChoice extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: <Widget>[

            Container(
                margin: EdgeInsets.fromLTRB(40, 0, 40, 0),
                child: FlatButton(onPressed:() {
                  DatabaseReference dbref = FirebaseDatabase.instance.reference().child("Test");
                  dbref.set("IsConnected");
                },

                  child: Text('Give vehicle on rent'.toUpperCase(), style: TextStyle(fontSize: 24.0)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding: EdgeInsets.fromLTRB(40, 20, 40, 20),
                  color: Colors.black,
                  textColor: Colors.white,
                )),
            SizedBox(
              height: 20,
            ),

            Container(
                margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: FlatButton(onPressed:() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DisplayMap()),
                  );
                },
                  child: Text('Rent a vehicle'.toUpperCase(), style: TextStyle(fontSize: 24.0)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding: EdgeInsets.fromLTRB(70, 20, 70, 20),
                  color: Colors.black,
                  textColor: Colors.white,
                )),
          ],
        ),
      ),


    );
  }
}
