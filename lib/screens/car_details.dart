import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vehicle_sharing_app/models/user.dart';
import '../widgets/widgets.dart';

class DetailsCar extends StatefulWidget {

  final AsyncSnapshot<VehicleUser> docSnapshot;

  DetailsCar({@required this.docSnapshot});

  @override
  _DetailsCarState createState() => _DetailsCarState();
}

class _DetailsCarState extends State<DetailsCar> {
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
        body: Column(
          children: <Widget>[

            SizedBox(
              height: 80,
            ),
            Row(
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
                      Text('Model Name',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(widget.docSnapshot.data.modelName,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Container(
                  margin: EdgeInsets.only(top: 50),
                  height: 300,
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  child: ListView(
                    children: [
                      Data(
                        carTitle: 'Owner Name  : ',
                        carInfo: widget.docSnapshot.data.ownerName,
                      ),
                      Data(
                        carTitle: 'Vehicle Color  : ',
                        carInfo: widget.docSnapshot.data.color,
                      ),
                      Data(
                        carTitle: 'Vehicle Number  : ',
                        carInfo: widget.docSnapshot.data.vehicleNumber,
                      ),
                      Data(
                        carTitle: 'Total Pay  : Rs',
                        carInfo: 'XXXX',
                      ),

                    ],
                  ),
                ),
              ),
            ),

            CustomButton(text: 'Pay', color:Colors.black, textColor: Colors.white)
          ],
        ),
      ),
    );
  }
}

class Data extends StatelessWidget {
  final String carTitle;
  final String carInfo;

  Data({this.carTitle, this.carInfo});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.arrow_forward_ios_rounded),
      title: Row(
        children: [
          Text(
            carTitle,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(
            width: 3,
          ),
          Text(
            carInfo,
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
