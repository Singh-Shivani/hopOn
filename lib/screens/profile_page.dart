import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vehicle_sharing_app/models/user.dart';
import 'package:vehicle_sharing_app/screens/detail_profile_page.dart';
import 'package:vehicle_sharing_app/screens/login_page.dart';
import 'package:vehicle_sharing_app/screens/owner_history.dart';
import 'package:vehicle_sharing_app/screens/ride_history_page.dart';
import 'package:vehicle_sharing_app/services/authentication_service.dart';
import 'package:vehicle_sharing_app/services/firebase_services.dart';
import 'package:vehicle_sharing_app/widgets/widgets.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            child: Padding(
              padding: EdgeInsets.only(top: 40, left: 20, right: 20),
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
                          // color: Colors.white,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          context
                              .read<AuthenticationService>()
                              .signOut(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return LoginPage();
                            }),
                          );
                        },
                        child: Icon(
                          Icons.logout,
                          // color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  FutureBuilder<AppUser>(
                    future: FirebaseFunctions().getUser(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ProfileData(
                          docSnapshot: snapshot,
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(
                              // backgroundColor: Colors.white,
                              ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Container(
                height: 240,
                // color: Colors.white,
                width: MediaQuery.of(context).size.width,
                child: ListView(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return OwnerHistory();
                          }),
                        );
                      },
                      child: ListTile(
                        leading: Icon(Icons.money_rounded),
                        title: Text(
                          'My Earnings',
                          style: TextStyle(fontSize: 14),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios_rounded),
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
                        leading: Icon(Icons.car_rental),
                        title: Text(
                          'My Rides',
                          style: TextStyle(fontSize: 14),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios_rounded),
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
}

class ProfileData extends StatelessWidget {
  final AsyncSnapshot<AppUser> docSnapshot;

  ProfileData({this.docSnapshot});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
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
          Text(
            docSnapshot.data.name,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            docSnapshot.data.emailID,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 12,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () {
              return Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return EditProfilePage(
                    docSnapshot: docSnapshot,
                  );
                }),
              );
            },
            child: CustomButton(
              text: 'Details',
            ),
          ),
        ],
      ),
    );
  }
}
