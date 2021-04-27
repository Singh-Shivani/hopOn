import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';

User currentFirebaseUser = FirebaseAuth.instance.currentUser;

DatabaseReference tripRequestRef;
StreamSubscription<Position> homeTabPositionStream;