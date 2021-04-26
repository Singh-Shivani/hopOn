import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vehicle_sharing_app/models/user.dart';
import 'package:vehicle_sharing_app/screens/login_page.dart';
import 'package:vehicle_sharing_app/services/authentication_service.dart';
import 'package:vehicle_sharing_app/services/firebase_services.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  AppUser userDetails;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
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
                  child: Icon(Icons.arrow_back_rounded),
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
                  child: Icon(Icons.logout),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            FutureBuilder<AppUser>(
              future: FirebaseFunctions().getUser(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Profile(
                    docSnapshot: snapshot,
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.black,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Profile extends StatelessWidget {
  final AsyncSnapshot<AppUser> docSnapshot;

  Profile({this.docSnapshot});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            width: 110,
            child: Image.asset('tanjiro.png'),
          ),
        ],
      ),
    );
  }
}
