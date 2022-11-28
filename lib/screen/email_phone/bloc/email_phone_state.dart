part of 'email_phone_bloc.dart';

abstract class EmailPhoneState {}

class EmailPhoneInitial extends EmailPhoneState {}

//**************
class EmailCheckState extends EmailPhoneState {
  bool isEmailValid;
  String emailExpMsg;
  EmailCheckState({required this.emailExpMsg, required this.isEmailValid});
}

class EmailSuccessState extends EmailPhoneState {
  bool isEmailValid;
  String emailExpMsg;
  EmailSuccessState({required this.emailExpMsg, required this.isEmailValid});
}

//*******
class PhoneCheckState extends EmailPhoneState {
  bool isPhoneValid;
  String phoneExpMsg;
  PhoneCheckState({required this.phoneExpMsg, required this.isPhoneValid});
}

class PhoneSuccessState extends EmailPhoneState {
  bool isPhoneValid;
  String phoneExpMsg;
  PhoneSuccessState({required this.phoneExpMsg, required this.isPhoneValid});
}
//****************

class EmailPhoneLoadCountresState extends EmailPhoneState {
  Country? currentLocation;
  List<Country> countries;
  EmailPhoneLoadCountresState(
      {required this.countries, required this.currentLocation});
}

class LoadinState extends EmailPhoneState {}
