part of 'email_phone_bloc.dart';

abstract class EmailPhoneState {}

class EmailPhoneInitial extends EmailPhoneState {}

class EmailState extends EmailPhoneState {
  String emailExpMsg;
  EmailState({required this.emailExpMsg});
}

class EmailValidationState extends EmailPhoneState {
  String emailExpMsg;
  EmailValidationState({required this.emailExpMsg});
}

class EmailCheckState extends EmailPhoneState {
  String emailExpMsg;
  EmailCheckState({required this.emailExpMsg});
}

class EmailPhoneLoadCountresState extends EmailPhoneState {
  final Country? currentLocation;
  List<Country> countries;
  EmailPhoneLoadCountresState(
      {required this.countries, required this.currentLocation});
}

class PhoneValidationState extends EmailPhoneState {
  String phoneExpMsg;
  PhoneValidationState({required this.phoneExpMsg});
}

class PhoneCheckState extends EmailPhoneState {
  String phoneExpMsg;
  PhoneCheckState({required this.phoneExpMsg});
}

class PhoneState extends EmailPhoneState {
  String phoneExpMsg;
  PhoneState({required this.phoneExpMsg});
}
