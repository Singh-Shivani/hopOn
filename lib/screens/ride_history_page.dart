import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:vehicle_sharing_app/globalvariables.dart';
import 'package:vehicle_sharing_app/screens/home_page.dart';

class RideHistory extends StatefulWidget {
  @override
  _RideHistoryState createState() => _RideHistoryState();
}

class _RideHistoryState extends State<RideHistory> {

  DatabaseReference dbref;
  List lists = [];
  @override
  void initState() {
    dbref = FirebaseDatabase.instance.reference().child("user_history/${currentFirebaseUser.uid}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
          padding: const EdgeInsets.all(40),
          children: <Widget>[
            Row(
            children: [
                GestureDetector(
                    onTap: () {
                    Navigator.pop(context);
                },
                child: Icon(
                    Icons.arrow_back_rounded,
                  // color: Colors.white,
                   ),
               ),
               SizedBox(
                  width: 25,
               ),
               Text('History Details'),
              ],
            ),
            FutureBuilder(
              future: dbref.once(),
              builder: (context, AsyncSnapshot<DataSnapshot> snapshot){
                if(snapshot.hasData){
                  lists.clear();
                  Map<dynamic,dynamic> values = snapshot.data.value;
                  if(values!=null){
                  values.forEach((key, values) {
                    lists.add(values);
                  });}
                  return new ListView.builder(
                    shrinkWrap: true,
                    itemCount: lists.length,
                    itemBuilder: (BuildContext context, int index){
                      return Card(
                        child: Container(
                          width: 300,
                          height: 200,
                          child: Row(
                            children: <Widget>[

                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Model Name: ' + lists[index]["modelName"],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Color: ' + lists[index]["color"],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Vehicle Number: ' + lists[index]["vehicleNumber"],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Owner Name: ' +lists[index]["ownerName"],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'From ' +lists[index]["pickupDate"] +' To '+lists[index]["dropofDate"],
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
                                      height: 15,
                                    ),

                                    GestureDetector(
                                      onTap: () {
                                        print(lists[index]['ownerId']);
                                        dbref = FirebaseDatabase.instance.reference().
                                                child("user_history/${currentFirebaseUser.uid}/${lists[index]['ownerId']}");
                                        dbref.onDisconnect();
                                        dbref.remove();

                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) {
                                            return HomePage();
                                          }),
                                        );
                                      },
                                      child: Text(
                                        'Cancel Ride',
                                        style: TextStyle(color:Colors.red, fontWeight: FontWeight.bold, fontSize: 14),
                                      ),
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
