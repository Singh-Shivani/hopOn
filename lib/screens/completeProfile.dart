import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vehicle_sharing_app/services/validation_services.dart';
import 'package:vehicle_sharing_app/widgets/widgets.dart';

class CompleteProfile extends StatefulWidget {
  @override
  _CompleteProfileState createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _licenseController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _bloodController = TextEditingController();
  TextEditingController _contactController = TextEditingController();

  File _image;

  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            GestureDetector(
              onTap: () => getImage(),
              child: CircleAvatar(
                radius: 0.1 * MediaQuery.of(context).size.width,
                child: Center(
                  child: (_image != null)
                      ? Image.file(
                          _image,
                          fit: BoxFit.cover,
                        )
                      : Icon(Icons.camera),
                ),
              ),
            ),
            InputFormField(
              fieldName: 'License Number',
              obscure: false,
              validator: ValidationService().licenseValidator,
              controller: _licenseController,
            ),
            InputFormField(
              fieldName: 'Age',
              obscure: false,
              validator: ValidationService().ageValidator,
              controller: _ageController,
            ),
            InputFormField(
              fieldName: 'Blood Group',
              obscure: false,
              validator: ValidationService().bloodValidator,
              controller: _bloodController,
            ),
            InputFormField(
              fieldName: 'Contact Number',
              obscure: false,
              validator: ValidationService().contactValidator,
              controller: _contactController,
            ),
            GestureDetector(
              onTap: () async {
                if (_formKey.currentState.validate() && _image != null) {
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('Processing')));
                }
              },
              child: CustomButton(
                text: 'Save',
              ),
            )
          ],
        ),
      ),
    );
  }
}
