class ValidationService {
  String emailValidator(String value) {
    if (value == null) {
      return 'Please enter a valid email';
    }

    if (!value.contains('@') && !value.contains('.')) {
      return 'Please enter a valid email';
    }

    // Pattern pattern = Pattern();

    // if (value.startsWith(pattern)) {
    //   return null;
    // }

    String pattern = r'^(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);

    if (!regExp.hasMatch(value[0])) {
      return 'Please enter a valid email';
    }

    return null;
  }

  String passswordValidator(String value) {
    if (value == null) {
      return 'Please enter a valid password';
    }

    if (value.length < 8) {
      return 'Please enter a password with more than 8 characters';
    }

    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);

    if (!regExp.hasMatch(value)) {
      return 'Please enter a valid password';
    }

    return null;
  }

  String ageValidator(int value) {
    if (value == null) {
      return 'Please enter a valid age';
    }

    if (value < 18) {
      return 'Please enter a valid age';
    }

    if (value > 100) {
      return 'Please enter a valid age';
    }

    return null;
  }

  String bloodValidator(String value) {
    if (value == null) {
      return 'Please enter a valid blood group';
    }

    String pattern = r'^(A|B|AB|O)[+-]$';
    RegExp regExp = new RegExp(pattern);

    if (!regExp.hasMatch(value)) {
      return 'Please enter a valid blood group';
    }

    return null;
  }

  String licenseValidator(String value) {
    if (value == null) {
      return 'Please enter a valid License Number';
    }

    String pattern =
        r'^(([A-Z]{2}[0-9]{2})( )|([A-Z]{2}-[0-9]{2}))((19|20)[0-9][0-9])[0-9]{7}$';
    RegExp regExp = new RegExp(pattern);

    if (!regExp.hasMatch(value)) {
      return 'Please enter a valid License Number';
    }

    return null;
  }

  String contactValidator(String value) {
    if (value == null) {
      return 'Please enter a valid phone number';
    }

    if (value.length != 10) {
      return 'Please enter a valid phone number';
    }

    String pattern =
        r'^[0-9]*$';
    RegExp regExp = new RegExp(pattern);

    if (!regExp.hasMatch(value)) {
      return 'Please enter a valid phone number';
    }

    return null;
  }
}
