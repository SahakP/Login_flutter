part of 'email_phone_bloc.dart';

abstract class EmailPhoneEvent {}

class EmailEvent extends EmailPhoneEvent {
  String email;
  EmailEvent({required this.email});
}

class PhoneEvent extends EmailPhoneEvent {
  String phone;
  PhoneEvent({required this.phone});
}

class EmailPhoneLoadCountresEvent extends EmailPhoneEvent {}
