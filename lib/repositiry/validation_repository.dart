class ValidationRepo {
  bool firstNameValidation(String name) {
    return name.isNotEmpty;
  }

  bool lastNameValidation(String name) {
    return name.isNotEmpty;
  }

  bool phoneValidation(String phone) {
    return phone.isNotEmpty;
  }

  bool passwordValidation(String password) {
    return password.length > 7;
  }

  bool birthdayValidation(DateTime validData) {
    final sixteenYear = 16 * 365 * 24 * 60 * 60 * 1000;
    final nowDate = DateTime.now();
    return nowDate.difference(validData).inMilliseconds >= sixteenYear;
  }

  bool emailValidation(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  bool nameValidation(String username) {
    return username.length > 4;
  }
}
