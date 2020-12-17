class AppUser {
  String name;
  String bloodGroup;
  String licenseNumber;
  String contact;
  String age;
  String emailID;
  String dpURL;
  bool hasCompleteProfile = false;

  AppUser();

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'bloodGroup': bloodGroup,
      'licenseNumber': licenseNumber,
      'contact': contact,
      'age': age,
      'emailID': emailID,
      'dpURL': dpURL,
      'hasCompletedProfile': hasCompleteProfile,
    };
  }

  AppUser.fromMap(Map<String, dynamic> data) {
    name = data['name'];
    bloodGroup = data['bloodGroup'];
    licenseNumber = data['licenseNumber'];
    contact = data['contact'];
    age = data['age'];
    emailID = data['emailID'];
    dpURL = data['dpURL'];
    hasCompleteProfile = data['hasCompleteProfile'];
  }
}
