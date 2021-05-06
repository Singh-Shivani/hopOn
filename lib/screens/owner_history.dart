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
          CustomBackButton(pageHeader: 'Ride of my car'),
          SizedBox(
            height: 30,
          ),
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
                    return Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SpecificationWidget(
                              text: lists[index]["userName"],
                              helpText: "Car taken by",
                            ),
                            SpecificationWidget(
                              text: lists[index]["age"],
                              helpText: "Age",
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
                            Text('Amount Received:\t\t'),
                            Text(
                              '₹ ${lists[index]["amount"]}\t\t\t',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                            Icon(Icons.check_circle),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return HomePage();
                              }),
                            );
                          },
                          child: CustomButton(
                            text: 'Book a ride',
                          ),
                        ),
                        SizedBox(
                          height: 300,
                        ),
                      ],
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
