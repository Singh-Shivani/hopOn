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
        // Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return HomePage();
          }),
        );
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
                    return Container(
                      height: 500,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SpecificationWidget(
                                text: lists[index]["modelName"],
                                helpText: "Your car",
                              ),
                              SpecificationWidget(
                                text: lists[index]["color"],
                                helpText: "Car's color",
                              ),
                              SpecificationWidget(
                                text: lists[index]["vehicleNumber"],
                                helpText: 'Car number',
                              ),
                              SpecificationWidget(
                                text: lists[index]["ownerName"],
                                helpText: 'Owner name',
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          SpecificationWidget(
                            text: lists[index]["pickUp"],
                            helpText: 'Pickup location',
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SpecificationWidget(
                            text: lists[index]["dropOff"],
                            helpText: 'DropOff location',
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Row(
                            children: [
                              Text('From\t\t'),
                              Text(
                                lists[index]["pickupDate"],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                              Text('\t\tTo\t\t'),
                              Text(
                                lists[index]["dropofDate"],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              Text('Amount Paid:\t\t'),
                              Text(
                                '₹ ${lists[index]["amount"]}\t\t\t',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                              Icon(Icons.check_circle),
                              SizedBox(
                                width: 50,
                              ),
                              GestureDetector(
                                onTap: () {
                                  showAlertDialog(context, index);
                                },
                                child: FlatButton(
                                  color: Colors.red,
                                  child: Text("Cancel ride",
                                      style: TextStyle(
                                        color: Colors.white,
                                      )),
                                  onPressed: () {
                                    showAlertDialog(context, index);
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 40,
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
                              child: CustomButton(
                                text: 'Book a ride',
                              )),
                        ],
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

class SpecificationWidget extends StatelessWidget {
  final String helpText;
  final String text;

  SpecificationWidget({@required this.text, @required this.helpText});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          text,
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 6,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            color: Color.fromRGBO(246, 246, 246, 1),
            borderRadius: BorderRadius.all(
              Radius.circular(6),
            ),
          ),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              helpText,
              style: TextStyle(fontSize: 10, color: Colors.black54),
            ),
          ),
        ),
      ],
    );
  }
}
