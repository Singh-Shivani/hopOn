import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hop_on/screens/give_vehicle/searchPage.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import '../../widgets/widgets.dart';

class DisplayMap extends StatefulWidget {

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  _DisplayMapState createState() => _DisplayMapState();
}

class _DisplayMapState extends State<DisplayMap> {

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController mapController;

  Position currentPosition;

  void setupPositionLocator() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
    currentPosition = position;

    LatLng pos = LatLng(position.latitude, position.longitude);
    CameraPosition cp = new CameraPosition(target: pos, zoom: 15);
    mapController.animateCamera(CameraUpdate.newCameraPosition(cp));

  }






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: Container(
        width: 250,
        color: Colors.white,
        child: DrawerList(),
      ),


      body: Stack(
          children: [
            GoogleMap(
              padding: EdgeInsets.only(bottom: 270),
              mapType: MapType.normal,
              myLocationButtonEnabled: true,
              initialCameraPosition: DisplayMap._kGooglePlex,
              myLocationEnabled: true,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: true,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
                mapController = controller;

                setupPositionLocator();

              },

            ),

            //Menu button
            Positioned(
              top: 44,
              left: 20,
              child: GestureDetector(
                onTap: (){
                  scaffoldKey.currentState.openDrawer();

                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26,
                            blurRadius: 5.0,
                            spreadRadius: 0.5,
                            offset: Offset(
                                0.7,
                                0.7
                            )
                        )
                      ]
                  ),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 20,
                    child: Icon(Icons.menu, color: Colors.black87,),
                  ),
                ),
              ),
            ),

            //Search Sheet
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: 270,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 15.0,
                        spreadRadius: 0.5,
                        offset: Offset(0.7, 0.7),

                      ),
                    ]
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 5,
                      ),
                      Text('Nice to see you!', style: TextStyle(fontSize: 10, color: Colors.black),),
                      Text('Where are you going?', style: TextStyle(fontSize: 18, color: Colors.black),),
                      SizedBox(height: 20,),

                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context)=> SearchPage()
                          ));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 5.0,
                                    spreadRadius: 0.5,
                                    offset: Offset(
                                        0.7,
                                        0.7
                                    )
                                )
                              ]
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.search, color: Colors.blueAccent),
                                SizedBox(width: 10,),
                                Text('Search Destination', style: TextStyle(fontSize:15, color: Colors.black),),
                              ],

                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 22,),

                      Row(
                        children: <Widget>[
                          Icon(OMIcons.home, color: Colors.black),
                          SizedBox(width: 12,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Add Home', style: TextStyle(fontSize: 18, color: Colors.black),),
                              SizedBox(height: 3,),
                              Text('Your residential address',
                                style: TextStyle(fontSize: 11,color: Colors.black54),)
                            ],
                          )
                        ],
                      ),

                      SizedBox(height: 10,),

                      BrandDivider(),

                      SizedBox(height: 16,),

                      Row(
                        children: <Widget>[
                          Icon(OMIcons.workOutline, color: Colors.black),
                          SizedBox(width: 12,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Add Work', style: TextStyle(fontSize: 18, color: Colors.black),),
                              SizedBox(height: 3,),
                              Text('Your office address',
                                style: TextStyle(fontSize: 11,color: Colors.black54),)
                            ],
                          )
                        ],
                      ),



                    ],
                  ),
                ),
              ),
            ),
          ],

      ),
    );
  }
}
