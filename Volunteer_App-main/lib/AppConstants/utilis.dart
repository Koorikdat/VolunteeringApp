
String? validateName(value) {
  if (value == null || value.isEmpty) {
    return 'User name is required';
  }
  // using regular expression
  String pattern = '([a-zA-Z])';
  RegExp regExp = RegExp(pattern);
  if (!regExp.hasMatch(value)) {
    return 'Please enter a valid name';
  }
  return null;
}


String? validateEmail(value) {
  if (value == null || value.isEmpty) {
    return 'Email is required';
  }
  // using regular expression
  if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
    return "Please enter a valid email address";
  }
  return null;
}

String? validatePassword(value) {
  if (value == null || value.isEmpty) {
    return "Password is required";
  }
  // Perform custom password validation here
  if (value.length < 6) {
    return "Password must be at least 6 characters long";
  }
  if (!value.contains(RegExp(r'[A-Z]'))) {
    return "Must contain at least one uppercase letter";
  }
  if (!value.contains(RegExp(r'[0-9]'))) {
    return "Must contain at least one numeric character";
  }
  return null;
}

String? validatePasswordSignIn(value) {
  if (value == null || value.isEmpty) {
    return "Password is required";
  }
  // Perform custom password validation here
  if (value.length < 6) {
    return "Password must be at least 6 characters long";
  }
  return null;
}