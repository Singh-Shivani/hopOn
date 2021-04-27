import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vehicle_sharing_app/models/user.dart';
import 'package:vehicle_sharing_app/screens/owner_homePage.dart';
import 'package:vehicle_sharing_app/services/firebase_services.dart';
import 'package:vehicle_sharing_app/services/validation_services.dart';
import 'package:vehicle_sharing_app/widgets/widgets.dart';
import 'package:connectivity/connectivity.dart';

class VehicleDetails extends StatefulWidget {
  @override
  _VehicleDetailsState createState() => _VehicleDetailsState();
}

class _VehicleDetailsState extends State<VehicleDetails> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _modelNameController = TextEditingController();
  TextEditingController _vehicleNumberController= TextEditingController();
  TextEditingController _ownerNameController = TextEditingController();
  TextEditingController _colorController = TextEditingController();
  TextEditingController _aadharcardController = TextEditingController();

  VehicleUser owner = VehicleUser();

  FirebaseFunctions firebaseFunctions = FirebaseFunctions();

  void initVehicleUser() {
    owner.modelName = _modelNameController.text;
    owner.vehicleNumber = _vehicleNumberController.text;
    owner.ownerName= _ownerNameController.text;
    owner.color = _colorController.text;
    owner.aadharNumber = _aadharcardController.text;
    owner.hasCompletedRegistration = true;
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Builder(
        builder: (context) {
          return Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 40),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 0.03 * deviceSize.height,
                    ),
                    InputFormField(
                      fieldName: 'Model Name',
                      obscure: false,
                      validator: ValidationService().modelNameValidator,
                      controller: _modelNameController,
                    ),
                    SizedBox(
                      height: 0.03 * deviceSize.height,
                    ),
                    InputFormField(
                      fieldName: 'Vehicle Number',
                      obscure: false,
                      validator: ValidationService().vehicleNumberValidator,
                      controller: _vehicleNumberController,
                    ),
                    SizedBox(
                      height: 0.03 * deviceSize.height,
                    ),
                    InputFormField(
                      fieldName: 'Owner Name',
                      obscure: false,
                      validator: ValidationService().ownerNameValidator,
                      controller: _ownerNameController,
                    ),
                    SizedBox(
                      height: 0.03 * deviceSize.height,
                    ),
                    InputFormField(
                      fieldName: 'Color',
                      obscure: false,
                      validator: ValidationService().colorValidator,
                      controller: _colorController,
                    ),
                    SizedBox(
                      height: 0.03 * deviceSize.height,
                    ),
                    InputFormField(
                      fieldName: 'Aadhar Number',
                      obscure: false,
                      validator: ValidationService().aadharNumberValidator,
                      controller: _aadharcardController,
                    ),
                    SizedBox(
                      height: 0.05 * deviceSize.height,
                    ),
                    GestureDetector(
                      onTap: () async {

                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Processing')));
                        initVehicleUser();
                        String isComplete = await firebaseFunctions
                            .uploadVehicleInfo(owner.toMap());
                        if (isComplete == 'true') {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return DisplayMap();
                              },
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(isComplete)));
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return VehicleDetails();
                              },
                            ),
                          );
                        }
                      },
                      child: CustomButton(
                        text: 'Submit',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}