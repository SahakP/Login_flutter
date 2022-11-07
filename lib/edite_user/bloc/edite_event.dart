part of 'edite_bloc.dart';

abstract class EditeEvent {}

class LastNameEvent extends EditeEvent {
  String lastName;
  String firstName;
  String phone;
  String name;
  // String password;
  String email;
  User user;
  LastNameEvent(
      {required this.lastName,
      required this.phone,
      required this.name,
      // required this.password,
      required this.email,
      required this.firstName,
      required this.user});
}
