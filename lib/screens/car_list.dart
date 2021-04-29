import 'package:flutter/material.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import '../globalvariables.dart';
import '../models/nearbyCar.dart';
import '../assistant/fireHelper.dart';
import '../services/firebase_services.dart';
import 'car_details.dart';

class CarList extends StatefulWidget {
  final List<dynamic> carlist;
  CarList({this.carlist});

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
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width:25,
              ),
              Text('Select a car'),
            ],
          ),
          backgroundColor: Colors.black,
        ),

        body: ListView(
          padding: const EdgeInsets.all(20),
          children: <Widget>[
            for(String car in widget.carlist)
              FutureBuilder(
                future: FirebaseFunctions().getOwner(car),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return  Card(
                      child: InkWell(
                        splashColor: Colors.blue.withAlpha(30),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>
                                DetailsCar(docSnapshot: snapshot,)),
                          );
                        },
                        child: Container(
                          width: 300,
                          height: 200,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Image(
                                    image: AssetImage('images/car.png'),
                                    fit: BoxFit.cover
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: 60,
                                    ),
                                    Text('Model Name: '+snapshot.data.modelName,
                                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text('Color: '+snapshot.data.color,
                                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text('Rs XXXX',
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                    ),
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
      ),
    );



  }
}
