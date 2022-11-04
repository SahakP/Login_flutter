class ValidationRepo {
  bool nameValidation(String userName) {
    return userName.isNotEmpty;
  }

  bool passwordValidation(String password) {
    return password.length > 7;
  }

  bool birthdayValid(DateTime validData) {
    final sixteenYear = 16 * 365 * 24 * 60 * 60 * 1000;
    final nowDate = DateTime.now();
    return nowDate.difference(validData).inMilliseconds >= sixteenYear;
  }

  bool isEmailValid(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  bool isUsernameValid(String username) {
    return username.length > 4;
  }
}
