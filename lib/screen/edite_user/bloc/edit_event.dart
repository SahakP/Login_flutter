part of 'edit_bloc.dart';

abstract class EditEvent {}

class EditUserEvent extends EditEvent {
  String? lastName;
  String? firstName;
  String? phone;
  String? name;
  String? password;
  String? email;
  String? birthday;
  User user;

  EditUserEvent(
      {required this.lastName,
      required this.phone,
      required this.name,
      required this.password,
      required this.birthday,
      required this.email,
      required this.firstName,
      required this.user});
}

class BirthdayEvent extends EditEvent {
  String? birthday;

  BirthdayEvent({
    required this.birthday,
  });
}

//class BackUserEditEvent extends EditEvent {}

class LastNameEvent extends EditEvent {
  String? lastName;
  LastNameEvent({required this.lastName});
}

class CancelEvent extends EditEvent {}

class OkButtonEvent extends EditEvent {}

class FirstNameEvent extends EditEvent {
  String? firstName;
  FirstNameEvent({required this.firstName});
}

class NameEvent extends EditEvent {
  String name;
  NameEvent({required this.name});
}

class PhoneEvent extends EditEvent {
  String phone;
  PhoneEvent({required this.phone});
}

class PasswordEvent extends EditEvent {
  String password;
  PasswordEvent({required this.password});
}

class EmailEvent extends EditEvent {
  String email;
  EmailEvent({required this.email});
}

class CountriesEvent extends EditEvent {}
