import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';

Position currentPosition;

String availabilityText = 'Give on rent';
Color availabilityColor = Colors.black;
bool isAvailable = false;
String exist = 'donotexist';

// String bookedCar;

User currentFirebaseUser = FirebaseAuth.instance.currentUser;

DatabaseReference tripRequestRef;
StreamSubscription<Position> homeTabPositionStream;

