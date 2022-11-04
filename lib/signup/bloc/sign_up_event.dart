part of 'sign_up_bloc.dart';

abstract class SignUpEvent {}

class FirstNameEvent extends SignUpEvent {
  String firstName;
  FirstNameEvent({required this.firstName});
}

class LastNameEvent extends SignUpEvent {
  String lastName;
  LastNameEvent({required this.lastName});
}
