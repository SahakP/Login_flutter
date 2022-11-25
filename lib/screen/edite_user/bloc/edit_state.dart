part of 'edit_bloc.dart';

abstract class EditState {}

class EdiiteInitial extends EditState {}

class EditUserState extends EditState {
  User? user;
  EditUserState({required this.user});
}

class CancelState extends EditState {}

class BirthdayState extends EditState {
  String? birthday;
  bool birthValid;
  BirthdayState({required this.birthday, required this.birthValid});
}

class LastNameState extends EditState {
  bool lastNameValid;
  LastNameState({required this.lastNameValid});
}

class OkButtonState extends EditState {}

class FirstNameState extends EditState {
  bool isFirstNameValid;
  FirstNameState({required this.isFirstNameValid});
}

//_____________________________
class NameSuccessState extends EditState {
  String nameExpMsg;
  bool isNameValid;
  NameSuccessState({required this.nameExpMsg, required this.isNameValid});
}

class NameCheckState extends EditState {
  bool isNameValid;
  String nameExpMsg;
  NameCheckState({required this.nameExpMsg, required this.isNameValid});
}

//_____________________________
class EmailCheckState extends EditState {
  bool isEmailValid;
  String emailExpMsg;
  EmailCheckState({required this.emailExpMsg, required this.isEmailValid});
}

class EmailSuccessState extends EditState {
  bool isEmailValid;
  String emailExpMsg;
  EmailSuccessState({required this.emailExpMsg, required this.isEmailValid});
}

//_______________________________
class PhoneCheckState extends EditState {
  bool isPhoneValid;
  String phoneExpMsg;
  PhoneCheckState({required this.phoneExpMsg, required this.isPhoneValid});
}

class PhoneSuccessState extends EditState {
  bool isPhoneValid;
  String phoneExpMsg;
  PhoneSuccessState({required this.phoneExpMsg, required this.isPhoneValid});
}

//________________________________
class PasswordState extends EditState {
  bool isPassValid;
  PasswordState({required this.isPassValid});
}

class CountriesState extends EditState {
  final Country? currentLocation;
  List<Country> countries;
  CountriesState({required this.countries, required this.currentLocation});
}

class LoadinState extends EditState {}
