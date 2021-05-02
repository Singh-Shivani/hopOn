import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vehicle_sharing_app/models/user.dart';
import 'package:vehicle_sharing_app/screens/home_page.dart';
import 'package:vehicle_sharing_app/widgets/widgets.dart';

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
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                CustomBackButton(pageHeader: 'My details'),
                SizedBox(
                  height: 30,
                ),
                CircleAvatar(
                  radius: 60,
                  foregroundColor: Colors.blue,
                  backgroundImage: AssetImage(
                    'images/ToyFaces_Colored_BG_47.jpg',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Info(
                    infoText: 'Name: ', infoData: widget.docSnapshot.data.name),
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
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ),
                    );
                  },
                  child: CustomButton(text: 'Book a ride'),
                ),
              ],
            ),
          ),
        ],
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              infoText,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 12,
              ),
            ),
            //
            Text(
              infoData,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 14,
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
