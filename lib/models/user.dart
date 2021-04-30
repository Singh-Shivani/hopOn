class AppUser {
  String name;
  String bloodGroup;
  String licenseNumber;
  String contact;
  String age;
  String emailID;
  // String dpURL;
  bool hasCompleteProfile = false;
  String uuid;

  AppUser();

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'bloodGroup': bloodGroup,
      'licenseNumber': licenseNumber,
      'contact': contact,
      'age': age,
      'emailID': emailID,
      // 'dpURL': dpURL,
      'hasCompletedProfile': hasCompleteProfile,
      'uuid': uuid,
    };
  }

  AppUser.fromMap(Map<String, dynamic> data) {
    name = data['name'];
    bloodGroup = data['bloodGroup'];
    licenseNumber = data['licenseNumber'];
    contact = data['contact'];
    age = data['age'];
    emailID = data['emailID'];
    // dpURL = data['dpURL'];
    hasCompleteProfile = data['hasCompleteProfile'];
    uuid = data['uuid'];
  }
}

class VehicleUser {
  String modelName;
  String vehicleNumber;
  String ownerName;
  String color;
  String aadharNumber;
  bool hasCompletedRegistration = false;
  String amount;

  VehicleUser();

  Map<String, dynamic> toMap() {
    return {
      'modelName': modelName,
      'vehicleNumber': vehicleNumber,
      'ownerName': ownerName,
      'color': color,
      'aadharNumber': aadharNumber,
      'hasCompletedRegistration': hasCompletedRegistration,
      'amount': amount,
    };
  }

  VehicleUser.fromMap(Map<String, dynamic> data) {
    modelName = data['modelName'];
    vehicleNumber = data['vehicleNumber'];
    ownerName = data['ownerName'];
    color = data['color'];
    aadharNumber = data['aadharNumber'];
    hasCompletedRegistration = data['hasCompletedRegistration'];
    amount = data['amount'];
  }
}
