import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vehicle_sharing_app/auth/user.dart';
import 'screens/landingPage.dart';
// import 'package:provider/provider.dart';
// import 'notifier/authNotifier.dart';


void main() {
  return runApp(  MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CurrentUser(),
      child: MaterialApp(
        title: 'Vehicle Sharing Platform',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Montserrat',

          primaryColor: Color.fromRGBO(0, 0, 0, 1),
        ),
        home: LandingPage(),
      ),
    );
  }
}
