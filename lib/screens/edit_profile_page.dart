import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vehicle_sharing_app/models/user.dart';

class EditProfilePage extends StatefulWidget {
  final AsyncSnapshot<AppUser> docSnapshot;
  EditProfilePage({@required this.docSnapshot});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_rounded,
                  ),
                ),
                Text('My details'),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Info(infoText: 'Name: ', infoData: widget.docSnapshot.data.name),
            Info(
                infoText: 'Email ID: ',
                infoData: widget.docSnapshot.data.emailID),
            Info(
                infoText: 'Blood group: ',
                infoData: widget.docSnapshot.data.bloodGroup),
            Info(
                infoText: 'Contact number: ',
                infoData: widget.docSnapshot.data.contact),
            Info(
                infoText: 'License number: ',
                infoData: widget.docSnapshot.data.licenseNumber),
          ],
        ),
      ),
    );
  }
}

class Info extends StatelessWidget {
  final String infoText;
  final String infoData;

  Info({this.infoText, this.infoData});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              infoText,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 14,
              ),
            ),
            SizedBox(
              width: 40,
            ),
            Text(
              infoData,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
