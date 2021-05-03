import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:vehicle_sharing_app/globalvariables.dart';
import 'package:vehicle_sharing_app/screens/home_page.dart';
import 'package:vehicle_sharing_app/widgets/widgets.dart';

class RideHistory extends StatefulWidget {
  @override
  _RideHistoryState createState() => _RideHistoryState();
}

class _RideHistoryState extends State<RideHistory> {
  DatabaseReference dbref;
  List lists = [];

  showAlertDialog(BuildContext context, int index) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      color: Colors.black,
      child: Text(
        "Back",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      color: Colors.red,
      child: Text("Yes, cancel ride",
          style: TextStyle(
            color: Colors.white,
          )),
      onPressed: () {
        print(lists[index]['ownerId']);
        dbref = FirebaseDatabase.instance.reference().child(
            "user_history/${currentFirebaseUser.uid}/${lists[index]['ownerId']}");
        dbref.onDisconnect();
        dbref.remove();
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("hopOn"),
      content: Text("Would you like to cancel your ride?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  void initState() {
    dbref = FirebaseDatabase.instance
        .reference()
        .child("user_history/${currentFirebaseUser.uid}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        children: <Widget>[
          CustomBackButton(pageHeader: 'My rides'),
          FutureBuilder(
            future: dbref.once(),
            builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
              if (snapshot.hasData) {
                lists.clear();
                Map<dynamic, dynamic> values = snapshot.data.value;
                if (values != null) {
                  values.forEach((key, values) {
                    lists.add(values);
                  });
                }
                return new ListView.builder(
                  shrinkWrap: true,
                  itemCount: lists.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: Container(
                        width: 500,
                        height: MediaQuery.of(context).size.height,
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 10,
                            ),
                            Info(
                              infoText: 'Model Name: ',
                              infoData: lists[index]["modelName"],
                            ),
                            Info(
                              infoText: 'Color: ',
                              infoData: lists[index]["color"],
                            ),
                            Info(
                              infoText: 'Vehicle Number: ',
                              infoData: lists[index]["vehicleNumber"],
                            ),
                            Info(
                              infoText: 'Owner Name: ',
                              infoData: lists[index]["ownerName"],
                            ),
                            Info(
                              infoText: 'PickUp: ',
                              infoData: lists[index]["pickUp"],
                            ),
                            Info(
                              infoText: 'DropOff: ',
                              infoData: lists[index]["dropOff"],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'From ' +
                                  lists[index]["pickupDate"] +
                                  ' To ' +
                                  lists[index]["dropofDate"],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Amount Paid : Rs. ${lists[index]["amount"]}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                showAlertDialog(context, index);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return HomePage();
                                  }),
                                );
                              },
                              child: CustomButton(text: 'Book a ride',)
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

class Info extends StatelessWidget {
  final String infoText;
  final String infoData;

  Info({this.infoText, this.infoData});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                infoText,
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 14,
                ),
              ),
            ),
            Expanded(
              child: Text(
                ':',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
            ),
            Expanded(
              child: Text(
                infoData,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
      ],
    );
  }
}
