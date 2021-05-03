import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:vehicle_sharing_app/globalvariables.dart';
import 'package:vehicle_sharing_app/screens/home_page.dart';
import 'package:vehicle_sharing_app/widgets/widgets.dart';

class OwnerHistory extends StatefulWidget {
  @override
  _OwnerHistoryState createState() => _OwnerHistoryState();
}

class _OwnerHistoryState extends State<OwnerHistory> {
  DatabaseReference dbref;
  List lists = [];
  @override
  void initState() {
    dbref = FirebaseDatabase.instance
        .reference()
        .child("owner_history/${currentFirebaseUser.uid}");
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
                        width: 300,
                        height: MediaQuery.of(context).size.height,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Info(
                                    infoText: 'User Name: ',
                                    infoData: lists[index]["userName"],
                                  ),
                                  Info(
                                    infoText: 'Age: ',
                                    infoData: lists[index]["age"],
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
                                    'Amount Received : Rs. ${lists[index]["amount"]}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
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
