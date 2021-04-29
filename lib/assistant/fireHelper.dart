import '../models/nearbyCar.dart';

class FireHelper{

  static List<NearbyCar> nearbyCarList = [];

  static void removeFromList(String key){
     int index = nearbyCarList.indexWhere((element) => element.key == key);
     nearbyCarList.removeAt(index);
  }

  static void updateNearByLocation(NearbyCar car){
    int index = nearbyCarList.indexWhere((element) => element.key == car.key);

    nearbyCarList[index].longitude = car.longitude;
    nearbyCarList[index].latitude = car.latitude;

  }
}