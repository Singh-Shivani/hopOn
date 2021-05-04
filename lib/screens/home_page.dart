import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:vehicle_sharing_app/assistant/assistantMethods.dart';
import 'package:vehicle_sharing_app/dataHandler/appdata.dart';
import 'package:vehicle_sharing_app/models/directionDetails.dart';
import 'package:vehicle_sharing_app/models/user.dart';
import 'package:vehicle_sharing_app/screens/about_us.dart';
import 'package:vehicle_sharing_app/screens/car_list.dart';
import 'package:vehicle_sharing_app/screens/profile_page.dart';
import 'package:vehicle_sharing_app/screens/ride_history_page.dart';
import 'package:vehicle_sharing_app/services/authentication_service.dart';
import 'package:vehicle_sharing_app/services/firebase_services.dart';
import 'package:vehicle_sharing_app/widgets/widgets.dart';

import '../assistant/fireHelper.dart';
import '../globalvariables.dart';
import '../models/nearbyCar.dart';
import 'login_page.dart';
import 'owner_homePage.dart';
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

  void geolocator = Geolocator();

  double rideDetailContainerHeight = 0;
  double searchDetailContainerHeight = 300;

  bool drawerOpen = true;
  String finalDestination = '';
  String initialLocation = '';

  List nearbyCarId = [];

  void displayRideDetailContainer() async {
    await getPlaceDirection();
    setState(() {
      searchDetailContainerHeight = 0;
      rideDetailContainerHeight = 330;
      bottomPaddingOfMap = 320;
      drawerOpen = false;
    });
  }

  resetApp() {
    setState(() {
      drawerOpen = true;
      searchDetailContainerHeight = 280;
      rideDetailContainerHeight = 0;
      bottomPaddingOfMap = 270;

      polylineSet.clear();
      markerSet.clear();
      pLinesCoordinates.clear();
      circleSet.clear();

      locatePosition();
    });
  }

  void locatePosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
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
    startGeofireListener();
  }

  void startGeofireListener() {
    // print(currentPosition);
    Geofire.initialize('carsAvailable');
    Geofire.queryAtLocation(
            currentPosition.latitude, currentPosition.longitude, 20)
        .listen((map) {
      // print(map);
      if (map != null) {
        var callBack = map['callBack'];

        //latitude will be retrieved from map['latitude']
        //longitude will be retrieved from map['longitude']

        switch (callBack) {
          case Geofire.onKeyEntered:
            NearbyCar nearbyCar = NearbyCar();
            nearbyCar.key = map['key'];
            nearbyCar.latitude = map['latitude'];
            nearbyCar.longitude = map['longitude'];

            nearbyCarId.add(map['key']);
            FireHelper.nearbyCarList.add(nearbyCar);
            break;

          case Geofire.onKeyExited:
            int index =
                nearbyCarId.indexWhere((element) => element.key == map['key']);
            nearbyCarId.removeAt(index);
            FireHelper.removeFromList(map['key']);
            break;

          case Geofire.onKeyMoved:
            // Update your key's location

            NearbyCar nearbyCar = NearbyCar();
            nearbyCar.key = map['key'];
            nearbyCar.latitude = map['latitude'];
            nearbyCar.longitude = map['longitude'];

            FireHelper.updateNearByLocation(nearbyCar);
            break;

          case Geofire.onGeoQueryReady:
            // All Intial Data is loaded
            print("Firehelper length: ${FireHelper.nearbyCarList.length}");

            break;
        }
      }
      NearbyCar nearbyCar = NearbyCar();
    });
  }

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  AppUser userData;

  DateTime selectedPickupDate = DateTime.now();
  DateTime selectedDropOffDate = DateTime.now();

  bool _decideWhichDayToEnable(DateTime day) {
    if ((day.isAfter(DateTime.now().subtract(Duration(days: 1))) &&
        day.isBefore(DateTime.now().add(Duration(days: 10))))) {
      return true;
    }
    return false;
  }

  _selectPickupDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedPickupDate, // Refer step 1
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
      initialEntryMode: DatePickerEntryMode.input,
      selectableDayPredicate: _decideWhichDayToEnable,
      helpText: 'Select pickup date', // Can be used as title
      cancelText: 'Not now',
      confirmText: 'Done',
      errorFormatText: 'Enter valid date',
      errorInvalidText: 'Enter date in valid range',
      fieldLabelText: 'Pickup date',
      fieldHintText: 'Month/Date/Year',
    );
    if (picked != null && picked != selectedPickupDate)
      setState(() {
        selectedPickupDate = picked;
      });
  }

  _selectDropOffDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDropOffDate, // Refer step 1
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
      initialEntryMode: DatePickerEntryMode.input,
      selectableDayPredicate: _decideWhichDayToEnable,
      helpText: 'Select dropOff date', // Can be used as title
      cancelText: 'Not now',
      confirmText: 'Done',
      errorFormatText: 'Enter valid date',
      errorInvalidText: 'Enter date in valid range',
      fieldLabelText: 'DropOff date',
      fieldHintText: 'Month/Date/Year',
    );
    if (picked != null && picked != selectedDropOffDate)
      setState(() {
        selectedDropOffDate = picked;
      });
  }

  @override
  void initState() {
    locatePosition();
    super.initState();
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
                        CircleAvatar(
                          radius: 40,
                          foregroundColor: Colors.blue,
                          backgroundImage: AssetImage(
                            'images/ToyFaces_Colored_BG_47.jpg',
                          ),
                        ),
                        //TODO 1: User photo should be here
                        SizedBox(width: 30),
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
                  leading: Icon(Icons.directions_car_rounded),
                  title: Text(
                    'Give my car on rent',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return RideHistory();
                    }),
                  );
                },
                child: ListTile(
                  leading: Icon(Icons.history),
                  title: Text(
                    'History',
                    // style: TextStyle(fontSize: 16),
                  ),
                ),
              ),

              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return AboutUs();
                    }),
                  );
                },
                child: ListTile(
                  leading: Icon(Icons.info_outline_rounded),
                  title: Text(
                    'About us',
                    // style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
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
                        style: TextStyle(fontSize: 13),
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
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(Icons.search),
                                Text(
                                  '\t\tDrop off location',
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
                        height: 20,
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
                                        ? (Provider.of<AppData>(context)
                                                    .pickUpLocation
                                                    .placeName
                                                    .length >
                                                40
                                            ? Provider.of<AppData>(context)
                                                    .pickUpLocation
                                                    .placeName
                                                    .substring(0, 41) +
                                                '\n' +
                                                Provider.of<AppData>(context)
                                                    .pickUpLocation
                                                    .placeName
                                                    .substring(41)
                                            : Provider.of<AppData>(context)
                                                .pickUpLocation
                                                .placeName)
                                        : 'Add Home',
                                    style: TextStyle(fontSize: 12),
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
                                      fontSize: 11, color: Colors.black54),
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
                                  style: TextStyle(fontSize: 12),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  'Your office address',
                                  style: TextStyle(
                                      fontSize: 11, color: Colors.black54),
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
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          ((initialLocation != '') ? initialLocation : ''),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
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
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Total Ride - \t',
                                  style: TextStyle(
                                    fontSize: 11,
                                  ),
                                ),
                                Text(
                                  ((tripDirectionDetails != null)
                                      ? tripDirectionDetails.distanceText
                                      : ''),
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Cost of Ride - \t',
                                  style: TextStyle(
                                    fontSize: 11,
                                  ),
                                ),
                                Text(
                                  ((tripDirectionDetails != null)
                                      ? '₹ ${AssistantMethods.calculateFares(tripDirectionDetails)}'
                                      : ''),
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Divider(),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${selectedPickupDate.toLocal()}"
                                      .split(' ')[0],
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _selectPickupDate(context);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 12),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 10,
                                        ),
                                      ],
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Select PickUp Date',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${selectedDropOffDate.toLocal()}"
                                      .split(' ')[0],
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _selectDropOffDate(context);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 12),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 10,
                                        ),
                                      ],
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Select DropOff Date',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return CarList(
                                  initialLocation: initialLocation,
                                  finalDestination: finalDestination,
                                  carlist: nearbyCarId,
                                  cost: ((tripDirectionDetails != null)
                                      ? AssistantMethods.calculateFares(
                                          tripDirectionDetails)
                                      : 0),
                                  pickupDate: "${selectedPickupDate.toLocal()}"
                                      .split(' ')[0],
                                  dropOffDate:
                                      "${selectedDropOffDate.toLocal()}"
                                          .split(' ')[0],
                                );
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
    // print('encoded points::');
    // print(details.encodedPoints);

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
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          infoWindow:
              InfoWindow(title: initialPos.placeName, snippet: 'PickUp'),
          position: pickUpLatLng,
          markerId: MarkerId('pickUpId'),
        );

        Marker dropOffLocMarker = Marker(
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
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
