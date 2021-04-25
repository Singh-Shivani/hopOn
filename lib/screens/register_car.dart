import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:vehicle_sharing_app/globalvariables.dart';
import '../widgets/widgets.dart';
import '../globalvariables.dart';
import 'owner_homePage.dart';

class VehicleDetails extends StatefulWidget {
  static const String _title = 'Enter details of vehicle';
  static const String id = 'vehicleinfo';

  @override
  _VehicleDetailsState createState() => _VehicleDetailsState();
}

class _VehicleDetailsState extends State<VehicleDetails> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  void showSnackBar(String title){
    final snackbar = SnackBar(
      content: Text(title, textAlign: TextAlign.center, style: TextStyle(fontSize: 15),),);
    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  var modelNameController = TextEditingController();

  var vehicleNumberController = TextEditingController();

  var ownerNameController = TextEditingController();

  var colorController = TextEditingController();

  var aadharcardController = TextEditingController();

  void updateProfile(context){
    if (currentFirebaseUser != null) {
    print('Updating');
    String id = currentFirebaseUser.user.uid;

    DatabaseReference driverRef = FirebaseDatabase.instance
        .reference()
        .child('users/$id/vehicle_details');

    driverRef.set({
      'model_name': modelNameController.text,
      'vehicle_no': vehicleNumberController.text,
      'owner_name': ownerNameController.text,
      'color': colorController.text,
      'aadhar_card': aadharcardController.text,
    });}



    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return DisplayMap();
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 60,
            ),
            InputTextField(
              controller: modelNameController,
              label: 'Model name',
              icon: Icon(Icons.car_rental),
            ),
            InputTextField(
              controller:  vehicleNumberController,
              label: 'Vehicle number',
              icon: Icon(Icons.details_outlined),
            ),
            InputTextField(
              controller: colorController,
              label: 'Color',
              icon: Icon(Icons.color_lens_outlined),
            ),
            InputTextField(
              controller: ownerNameController,
              label: 'Owner Name',
              icon: Icon(Icons.person),
            ),
            InputTextField(
              controller: aadharcardController,
              label: 'Aadhar card number',
              icon: Icon(Icons.perm_identity),
            ),

            SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () async {

                // network connectivity
                var connectivityResult = await Connectivity().checkConnectivity();
                if(connectivityResult != ConnectivityResult.mobile && connectivityResult != ConnectivityResult.wifi){
                  showSnackBar('No Internet connectivity');
                  return;
                }

                if(modelNameController.text.length < 2){
                  showSnackBar('Please provide a valid model name');
                }
                if(vehicleNumberController.text.length < 4){
                  showSnackBar('Please provide a valid vehicle number');
                }
                if(ownerNameController.text.length < 3){
                  showSnackBar('Please provide a valid full name');
                }
                if(colorController.text.length < 2){
                  showSnackBar('Please provide a valid color');
                }
                if(aadharcardController.text.length < 12){
                  showSnackBar('Please provide a valid Aadhar Card number');
                }
                updateProfile(context);

              },
              // child: AvailabilityButton(text: 'Submit'),
            ),
            Text('\nGo back to home page'),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return DisplayMap();
                  }),
                );
              },
              child: Text(
                'Click here',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}






