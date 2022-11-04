part of 'password_bloc.dart';

abstract class PasswordEvent {}

class PassEvent extends PasswordEvent {
  String password;
  PassEvent({required this.password});
}

class PassDbEvent extends PasswordEvent {
  User user;
  PassDbEvent({required this.user});
}
