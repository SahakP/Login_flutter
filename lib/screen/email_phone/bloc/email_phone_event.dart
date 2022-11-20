part of 'email_phone_bloc.dart';

abstract class EmailPhoneEvent {}

class EmailEvent extends EmailPhoneEvent {
  final String email;
  EmailEvent({required this.email});
}

class PhoneEvent extends EmailPhoneEvent {
  final String phone;
  PhoneEvent({required this.phone});
}

class EmailPhoneLoadCountresEvent extends EmailPhoneEvent {}
