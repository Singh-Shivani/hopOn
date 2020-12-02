import 'package:flutter/material.dart';
import 'screens/landingPage.dart';
// import 'package:provider/provider.dart';
// import 'notifier/authNotifier.dart';


void main() {
  // runApp(MultiProvider(
  //   providers: [
  //     ChangeNotifierProvider(
  //       create: (_) => AuthNotifier(),
  //     ),
  //
  //   ],
  //   child: MyApp(),
  // ));
  return runApp(  MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vehicle Sharing Platform',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Montserrat',

        primaryColor: Color.fromRGBO(0, 0, 0, 1),
      ),
      home: LandingPage(),
    );
  }
}
