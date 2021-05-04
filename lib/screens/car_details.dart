import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vehicle_sharing_app/models/user.dart';
import 'package:vehicle_sharing_app/screens/payement_gateway_page.dart';

import '../widgets/widgets.dart';

class DetailsCar extends StatefulWidget {
  final AsyncSnapshot<VehicleUser> docSnapshot;
  final String bookedCar;
  String finalDestination;
  String initialLocation;
  final int rideCost;
  final String pickupDate;
  final String dropOffDate;
  DetailsCar(
      {@required this.docSnapshot,
      @required this.bookedCar,
      @required this.finalDestination,
      @required this.initialLocation,
      @required this.rideCost,
      @required this.pickupDate,
      @required this.dropOffDate});

  @override
  _DetailsCarState createState() => _DetailsCarState();
}

var totalCost;

class _DetailsCarState extends State<DetailsCar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(235, 235, 240, 1),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(40),
                  bottomLeft: Radius.circular(40),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomBackButton(
                      pageHeader: '',
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      widget.docSnapshot.data.modelName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                    Text(
                      widget.docSnapshot.data.ownerName.toUpperCase(),
                      style: TextStyle(
                        color: Color.fromRGBO(27, 34, 46, 1),
                        fontSize: 12,
                        letterSpacing: 1,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Image.network(
                      widget.docSnapshot.data.vehicleImg,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SPECIFICATIONS',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SpecificationWidget(
                        text: '₹ ' + widget.docSnapshot.data.amount,
                        helpText: 'Car rent',
                      ),
                      SpecificationWidget(
                        text: '₹ ' + widget.rideCost.toString(),
                        helpText: 'Your ride cost',
                      ),
                      SpecificationWidget(
                        text: '₹ ' +
                            (widget.rideCost +
                                    (int.parse(widget.docSnapshot.data.amount)))
                                .toString(),
                        helpText: 'Total cost',
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SpecificationWidget(
                        text: widget.docSnapshot.data.color,
                        helpText: "Car's Color",
                      ),
                      SpecificationWidget(
                        text: widget.pickupDate,
                        helpText: 'Pickup date',
                      ),
                      SpecificationWidget(
                        text: widget.dropOffDate,
                        helpText: 'DropOff date',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 100,
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentPage(
                        docSnapshot: widget.docSnapshot,
                        initialLocation: widget.initialLocation,
                        finalDestination: widget.finalDestination,
                        bookedCar: widget.bookedCar,
                        amount: (widget.rideCost +
                                (int.parse(widget.docSnapshot.data.amount)))
                            .toString(),
                        pickupDate: widget.pickupDate,
                        dropOffDate: widget.dropOffDate,
                      ),
                    ),
                  );
                },
                child: CustomButton(
                  text: 'Pay',
                ),
              ),
            ),
          ],
        ),
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
