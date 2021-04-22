import 'package:flutter/cupertino.dart';
import 'package:vehicle_sharing_app/models/address.dart';

class AppData extends ChangeNotifier {
  Address pickUpLocation;

  void updatePickUpLocation(Address pickUpAddress) {
    pickUpLocation = pickUpAddress;
    notifyListeners();
  }
}
