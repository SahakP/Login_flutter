part of 'email_phone_bloc.dart';

abstract class EmailPhoneState {}

class EmailPhoneInitial extends EmailPhoneState {}

class EmailState extends EmailPhoneState {
  bool isEmailValid;
  EmailState({required this.isEmailValid});
}

class PhoneState extends EmailPhoneState {
  bool isPhoneValid;
  PhoneState({required this.isPhoneValid});
}

class EmailPhoneLoadCountresState extends EmailPhoneState {
  final Country? currentLocation;
  List<Country> countries;
  EmailPhoneLoadCountresState(
      {required this.countries, required this.currentLocation});
}
