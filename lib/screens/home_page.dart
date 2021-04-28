import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:vehicle_sharing_app/assistant/assistantMethods.dart';
import 'package:vehicle_sharing_app/dataHandler/appdata.dart';
import 'package:vehicle_sharing_app/models/directionDetails.dart';
import 'package:vehicle_sharing_app/models/user.dart';
import 'package:vehicle_sharing_app/screens/car_list.dart';
import 'package:vehicle_sharing_app/screens/profile_page.dart';
import 'package:vehicle_sharing_app/services/firebase_services.dart';
import 'package:vehicle_sharing_app/widgets/widgets.dart';
import  'owner_homePage.dart';

import 'search_dropOff.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  GoogleMapController newGoogleMapController;

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  DirectionDetails tripDirectionDetails;

  List<LatLng> pLinesCoordinates = [];
  Set<Polyline> polylineSet = {};

  double bottomPaddingOfMap = 0;

  Set<Marker> markerSet = {};
  Set<Circle> circleSet = {};

  Position currentPosition;
  void geolocator = Geolocator();

  double rideDetailContainerHeight = 0;
  double searchDetailContainerHeight = 300;

  bool drawerOpen = true;
  String finalDestination = '';
  String initialLocation = '';

  void displayRideDetailContainer() async {
    await getPlaceDirection();
    setState(() {
      searchDetailContainerHeight = 0;
      rideDetailContainerHeight = 240;
      bottomPaddingOfMap = 230;
      drawerOpen = false;
    });
  }

  resetApp() {
    setState(() {
      drawerOpen = true;
      searchDetailContainerHeight = 240;
      rideDetailContainerHeight = 0;
      bottomPaddingOfMap = 230;

      polylineSet.clear();
      markerSet.clear();
      pLinesCoordinates.clear();
      circleSet.clear();

      locatePosition();
    });
  }

  void locatePosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;
    LatLng latlngPosition = LatLng(position.latitude, position.longitude);
    CameraPosition cameraPosition =
        new CameraPosition(target: latlngPosition, zoom: 14);
    newGoogleMapController
        .moveCamera(CameraUpdate.newCameraPosition(cameraPosition));

    String address =
        await AssistantMethods.searchCoordinateAddress(position, context);
    if (address == '') {
      print('Nulladdress');
    }
    print('Your address::' + address);
  }

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  AppUser userData;
  @override
  void initState() {
    getUser();
    locatePosition();
    super.initState();
  }

  getUser() async {
    userData = await FirebaseFunctions().getUser();
    setState(() {
      userData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      drawer: Container(
        width: 255,
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
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            // color: Colors.black26,
                          ),
                          width: 50,
                          child: Image.asset('images/tanjiro.png'),
                        ),
                        //TODO 1: User photo should be here
                        SizedBox(width: 40),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            userData.name != null
                                ? Text(userData.name)
                                : Text('Name'),
                            SizedBox(height: 8),
                            Text(
                              'Visit Profile',
                              style: TextStyle(color: Colors.black54),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ), //Drawer Header
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return DisplayMap();
                    }),
                  );
                },
                child: ListTile(
                  leading: Icon(Icons.electric_car_rounded),
                  title: Text(
                    'Give car on rent',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.history),
                title: Text(
                  'History',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              ListTile(
                leading: Icon(Icons.info_outline_rounded),
                title: Text(
                  'About us',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            padding: EdgeInsets.only(bottom: bottomPaddingOfMap),
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            initialCameraPosition: _kGooglePlex,
            myLocationEnabled: true,
            zoomControlsEnabled: true,
            zoomGesturesEnabled: true,
            compassEnabled: true,
            polylines: polylineSet,
            markers: markerSet,
            circles: circleSet,
            onMapCreated: (GoogleMapController controller) {
              _controllerGoogleMap.complete(controller);
              newGoogleMapController = controller;
              setState(() {
                bottomPaddingOfMap = 300;
              });
              locatePosition();
            },
          ),
          //Hamburger button for Drawer
          Positioned(
            top: 45,
            left: 15,
            child: GestureDetector(
              onTap: () {
                if (drawerOpen) {
                  scaffoldKey.currentState.openDrawer();
                } else {
                  resetApp();
                }
              },
              child: Container(
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    ((drawerOpen) ? Icons.menu : Icons.close),
                    color: Colors.black,
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 6,
                      spreadRadius: 0.5,
                      offset: Offset(0.7, 0.7),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: AnimatedSize(
              vsync: this,
              curve: Curves.bounceIn,
              duration: Duration(milliseconds: 500),
              child: Container(
                height: searchDetailContainerHeight,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black54,
                      blurRadius: 16,
                      spreadRadius: 0.2,
                      offset: Offset(1, 1),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hi there,',
                        style: TextStyle(fontSize: 11),
                      ),
                      Text(
                        'Hoping to?',
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () async {
                          var res = await Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return SearchDropOffLocation();
                            }),
                          );

                          if (res == 'obtainDirection') {
                            displayRideDetailContainer();
                          }
                        },
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(Icons.search),
                                Text(
                                  '\tDrop off location',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black54),
                                ),
                              ],
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black54,
                                blurRadius: 4,
                                spreadRadius: 0.2,
                                offset: Offset(0.7, 0.7),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.home),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(
                                    Provider.of<AppData>(context)
                                                .pickUpLocation !=
                                            null
                                        ? Provider.of<AppData>(context)
                                            .pickUpLocation
                                            .placeName
                                        : 'Add Home',
                                    style: TextStyle(fontSize: 13),
                                    // overflow: TextOverflow.ellipsis,
                                    // maxLines: 1,
                                  ),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  'Your home address',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.black54),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Divider(),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.work),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Add Office?',
                                  style: TextStyle(fontSize: 14),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  'Your office address',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.black54),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: AnimatedSize(
              vsync: this,
              curve: Curves.bounceIn,
              duration: Duration(milliseconds: 500),
              child: Container(
                height: rideDetailContainerHeight,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black54,
                      blurRadius: 16,
                      spreadRadius: 0.2,
                      offset: Offset(1, 1),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    children: [
                      Text(
                        ((initialLocation != '') ? initialLocation : ''),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text('To'),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        ((finalDestination != '') ? finalDestination : ''),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                Text('Total Ride - \t'),
                                Text(
                                  ((tripDirectionDetails != null)
                                      ? tripDirectionDetails.distanceText
                                      : ''),
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text('Cost of Ride - \t'),
                                Text(
                                  ((tripDirectionDetails != null)
                                      ? 'Rs. ${AssistantMethods.calculateFares(tripDirectionDetails)}'
                                      : ''),
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return CarList();
                            }),
                          );
                        },
                        child: CustomButton(
                          text: 'Next',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> getPlaceDirection() async {
    var initialPos =
        Provider.of<AppData>(context, listen: false).pickUpLocation;
    var finalPos = Provider.of<AppData>(context, listen: false).dropOffLocation;

    var pickUpLatLng = LatLng(initialPos.latitude, initialPos.longitude);
    var dropOffLatLng = LatLng(finalPos.latitude, finalPos.longitude);

    showDialog(
      context: context,
      builder: (BuildContext context) =>
          ProgressDialog(status: 'Please Wait....'),
    );

    var details = await AssistantMethods.obtainPlaceDirectionDetails(
        pickUpLatLng, dropOffLatLng);
    setState(() {
      tripDirectionDetails = details;
      finalDestination = finalPos.placeName;
      initialLocation = initialPos.placeName;
    });

    Navigator.pop(context);
    print('encoded points::');
    print(details.encodedPoints);

    PolylinePoints polylinePoints = PolylinePoints();

    List<PointLatLng> decodedPolylinePointResult =
        polylinePoints.decodePolyline(details.encodedPoints);

    pLinesCoordinates.clear();

    if (decodedPolylinePointResult.isNotEmpty) {
      decodedPolylinePointResult.forEach((PointLatLng pointLatLng) {
        pLinesCoordinates
            .add(LatLng(pointLatLng.latitude, pointLatLng.longitude));
      });
    }

    polylineSet.clear();

    setState(
      () {
        Polyline polyline = Polyline(
          color: Colors.green,
          polylineId: PolylineId('PolyLineID'),
          jointType: JointType.round,
          width: 5,
          startCap: Cap.roundCap,
          endCap: Cap.roundCap,
          points: pLinesCoordinates,
          geodesic: true,
        );

        polylineSet.add(polyline);

        LatLngBounds latLngBounds;

        if (pickUpLatLng.latitude > dropOffLatLng.latitude &&
            pickUpLatLng.longitude > dropOffLatLng.longitude) {
          latLngBounds =
              LatLngBounds(southwest: dropOffLatLng, northeast: pickUpLatLng);
        } else if (pickUpLatLng.longitude > dropOffLatLng.longitude) {
          latLngBounds = LatLngBounds(
            southwest: LatLng(pickUpLatLng.latitude, dropOffLatLng.longitude),
            northeast: LatLng(dropOffLatLng.latitude, pickUpLatLng.longitude),
          );
        } else if (pickUpLatLng.latitude > dropOffLatLng.latitude) {
          latLngBounds = LatLngBounds(
            southwest: LatLng(dropOffLatLng.latitude, pickUpLatLng.longitude),
            northeast: LatLng(pickUpLatLng.latitude, dropOffLatLng.longitude),
          );
        } else {
          latLngBounds =
              LatLngBounds(southwest: pickUpLatLng, northeast: dropOffLatLng);
        }

        newGoogleMapController.animateCamera(
          CameraUpdate.newLatLngBounds(latLngBounds, 100),
        );

        Marker pickUpLocMarker = Marker(
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          infoWindow:
              InfoWindow(title: initialPos.placeName, snippet: 'PickUp'),
          position: pickUpLatLng,
          markerId: MarkerId('pickUpId'),
        );

        Marker dropOffLocMarker = Marker(
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          infoWindow: InfoWindow(title: finalPos.placeName, snippet: 'DropOff'),
          position: dropOffLatLng,
          markerId: MarkerId('dropOffId'),
        );

        setState(() {
          markerSet.add(pickUpLocMarker);
          markerSet.add(dropOffLocMarker);
        });

        Circle pickUpLocCircle = Circle(
          fillColor: Colors.blueAccent,
          center: pickUpLatLng,
          radius: 12,
          strokeWidth: 4,
          strokeColor: Colors.blueAccent,
          circleId: CircleId('pickUpId'),
        );

        Circle dropOffLocCircle = Circle(
          fillColor: Colors.deepPurple,
          center: dropOffLatLng,
          radius: 12,
          strokeWidth: 4,
          strokeColor: Colors.deepPurple,
          circleId: CircleId('dropOffId'),
        );

        setState(() {
          circleSet.add(pickUpLocCircle);
          circleSet.add(dropOffLocCircle);
        });
      },
    );
  }
}
