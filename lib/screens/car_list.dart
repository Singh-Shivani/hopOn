import 'package:flutter/material.dart';

import '../services/firebase_services.dart';
import 'car_details.dart';

class CarList extends StatefulWidget {
  final List<dynamic> carlist;
  final int cost;
  String pickupDate;
  String dropOffDate;
  CarList({this.carlist, this.cost, this.dropOffDate, this.pickupDate});

  @override
  _CarListState createState() => _CarListState();
}

class _CarListState extends State<CarList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(245, 245, 242, 1),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children: <Widget>[
          Row(
            children: [
              SizedBox(
                height: 45,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_rounded,
                  // color: Colors.white,
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    'Available Cars',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          for (String car in widget.carlist)
            FutureBuilder(
              future: FirebaseFunctions().getOwner(car),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsCar(
                            docSnapshot: snapshot,
                            rideCost: widget.cost,
                            pickupDate: widget.pickupDate,
                            dropOffDate: widget.dropOffDate,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                      margin: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Column(
                        children: <Widget>[
                          Image.asset('images/blackcar.png'),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    snapshot.data.modelName,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                  Text(
                                    '₹' + snapshot.data.amount,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    '₹' + widget.cost.toString(),
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Ride amount',
                                    style: TextStyle(fontSize: 11),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.arrow_forward,
                                size: 20,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                    ),
                  );
                }
              },
            ),
        ],
      ),
    );
  }
}
