part of 'edit_bloc.dart';

abstract class EditEvent {}

class EditUserEvent extends EditEvent {
  String lastName;
  String firstName;
  String phone;
  String name;
  String password;
  String email;
  String birthday;
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
  BirthdayEvent({required this.birthday});
}

class BackUserEditEvent extends EditEvent {}

class LastNameEvent extends EditEvent {
  String? lastName;
  LastNameEvent({required this.lastName});
}
