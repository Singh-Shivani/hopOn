import 'package:flutter/material.dart';

class RideHistory extends StatefulWidget {
  @override
  _RideHistoryState createState() => _RideHistoryState();
}

class _RideHistoryState extends State<RideHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.blue,
          child: Text(
            'Ride History',
          ),
        ),
      ),
    );
  }
}
