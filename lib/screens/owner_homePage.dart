import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:vehicle_sharing_app/globalvariables.dart';
import 'package:vehicle_sharing_app/models/user.dart';
import 'package:vehicle_sharing_app/services/authentication_service.dart';
import 'package:vehicle_sharing_app/services/firebase_services.dart';
import 'package:vehicle_sharing_app/widgets/confirmSheet.dart';

import '../widgets/widgets.dart';
import 'car_registration.dart';
import 'home_page.dart';
import 'login_page.dart';
import 'owner_history.dart';
import 'profile_page.dart';

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

  void showSnackBar(String title) {
    final snackbar = SnackBar(
      content: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 15),
      ),
    );
    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController mapController;

  Position currentPosition;
  AppUser userData;

  DatabaseReference tripRequestRef;
  var locationOptions = LocationOptions(
      accuracy: LocationAccuracy.bestForNavigation, distanceFilter: 4);

  String availabilityText = 'Give on rent';
  Color availabilityColor = Colors.black;
  bool isAvailable = false;
  String exist = 'donotexist';

  void setupPositionLocator() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;

    LatLng pos = LatLng(position.latitude, position.longitude);
    CameraPosition cp = CameraPosition(target: pos, zoom: 15);
    mapController.animateCamera(CameraUpdate.newCameraPosition(cp));
  }

  @override
  void initState() {
    getUser();
    setupPositionLocator();
    super.initState();
  }

  getUser() async {
    userData = await FirebaseFunctions().getUser();
    // setState(() {
    //   userData;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: Container(
        width: 250,
        color: Colors.white,
        child: Drawer(
          child: ListView(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return ProfilePage();
                    }),
                  );
                },
                child: Container(
                  height: 165,
                  child: DrawerHeader(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 40,
                              foregroundColor: Colors.blue,
                              backgroundImage: AssetImage(
                                'images/ToyFaces_Colored_BG_47.jpg',
                              ),
                            ),
                            //TODO 1: User photo should be here
                            SizedBox(width: 20),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FutureBuilder<AppUser>(
                                  future: FirebaseFunctions().getUser(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Text(
                                        snapshot.data.name,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      );
                                    } else {
                                      return Text('Name');
                                    }
                                  },
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Visit Profile',
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 12),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return HomePage();
                  }));
                },
                child: ListTile(
                  leading: Icon(Icons.directions_car_rounded),
                  title: Text(
                    'Book a ride',
                    // style: TextStyle(fontSize: 1),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return VehicleDetails();
                  }));
                },
                child: ListTile(
                  leading: Icon(Icons.card_membership_rounded),
                  title: Text(
                    'Register your car',
                    // style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return OwnerHistory();
                  }));
                },
                child: ListTile(
                  leading: Icon(Icons.history),
                  title: Text(
                    'My Car History',
                    // style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              //Drawer Header

              GestureDetector(
                onTap: () {
                  context.read<AuthenticationService>().signOut(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return LoginPage();
                    }),
                  );
                },
                child: ListTile(
                  leading: Icon(Icons.logout),
                  title: Text(
                    'Sign Out',
                    // style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            padding: EdgeInsets.only(bottom: 240),
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            initialCameraPosition: DisplayMap._kGooglePlex,
            myLocationEnabled: true,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
            compassEnabled: true,
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
              onTap: () {
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
                          offset: Offset(0.7, 0.7))
                    ]),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 20,
                  child: Icon(
                    Icons.menu,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 125,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 15.0,
                      spreadRadius: 0.5,
                      offset: Offset(0.7, 0.7),
                    ),
                  ]),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 5,
                    ),
                    GestureDetector(
                      onTap: () async {
                        await checkIfDocExists();
                        if (exist == 'docexist') {
                          showModalBottomSheet(
                              isDismissible: false,
                              context: context,
                              builder: (BuildContext context) => ConfirmSheet(
                                    title: (!isAvailable)
                                        ? 'Give my car on rent'
                                        : "Don't want to keep the car for others?",
                                    subtitle: (!isAvailable)
                                        ? 'Want to give your car on rent?'
                                        : 'Want to remove your car from renting?',
                                    onPressed: () {
                                      if (!isAvailable) {
                                        goOnline();
                                        getLocationUpdates();
                                        Navigator.pop(context);
                                        setState(() {
                                          availabilityColor = Colors.green;
                                          availabilityText = 'Remove from rent';
                                          isAvailable = true;
                                        });
                                      } else {
                                        goOffline();
                                        Navigator.pop(context);
                                        setState(() {
                                          availabilityColor = Colors.black;
                                          availabilityText =
                                              'Give my car on rent';
                                          isAvailable = false;
                                        });
                                      }
                                    },
                                  ));
                        } else {
                          showSnackBar(exist);
                        }
                      },
                      child: AvailabilityButton(
                        text: availabilityText,
                        color: availabilityColor,
                      ),
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

  /// Check If Vehicle Info Exists
  Future<void> checkIfDocExists() async {
    try {
      var collectionRef = FirebaseFirestore.instance
          .collection('users/${currentFirebaseUser.uid}/vehicle_details');

      var doc = await collectionRef.doc(currentFirebaseUser.uid).get();
      if (doc.exists) {
        exist = 'docexist';
      } else {
        exist = 'Please Register Your Car';
      }
    } catch (e) {
      exist = e;
    }
  }

  void goOnline() {
    print(currentFirebaseUser.uid);
    print("entered");

    Geofire.initialize('carsAvailable');
    Geofire.setLocation(currentFirebaseUser.uid, currentPosition.latitude,
        currentPosition.longitude);

    tripRequestRef = FirebaseDatabase.instance
        .reference()
        .child('cars/${currentFirebaseUser.uid}/newTrip');
    tripRequestRef.set('waiting');

    tripRequestRef.onValue.listen((event) {});
  }

  void getLocationUpdates() {
    print("location updates");

    homeTabPositionStream =
        Geolocator.getPositionStream().listen((Position position) {
      currentPosition = position;
      if (isAvailable) {
        Geofire.setLocation(
            currentFirebaseUser.uid, position.latitude, position.longitude);
      }
      LatLng pos = LatLng(position.latitude, position.longitude);
      CameraPosition cp = new CameraPosition(target: pos, zoom: 15);
      mapController.animateCamera(CameraUpdate.newCameraPosition(cp));
    });
  }

  void goOffline() {
    Geofire.removeLocation(currentFirebaseUser.uid);
    tripRequestRef.onDisconnect();
    tripRequestRef.remove();
    tripRequestRef = null;
  }
}
