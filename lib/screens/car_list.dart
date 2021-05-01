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
              Text('Select a car'),
            ],
          ),
          for (String car in widget.carlist)
            FutureBuilder(
              future: FirebaseFunctions().getOwner(car),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Card(
                    child: GestureDetector(
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
                        print(totalCost);
                      },
                      child: Container(
                        width: 300,
                        height: 200,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Image(
                                  image: AssetImage('images/car.png'),
                                  fit: BoxFit.cover),
                            ),
                            Expanded(
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 60,
                                  ),
                                  Text(
                                    'Model Name: ' + snapshot.data.modelName,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Color: ' + snapshot.data.color,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Rs.' + snapshot.data.amount,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                  Text('cost of ride' + widget.cost.toString())
                                ],
                              ),
                            ),
                          ],
                        ),
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
