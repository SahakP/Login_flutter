part of 'login_bloc.dart';

abstract class LoginEvent {}

class LogInButtonEvent extends LoginEvent {
  String userName;
  String password;
  LogInButtonEvent({required this.userName, required this.password});
}

class UserNameEvent extends LoginEvent {
  String userName;
  UserNameEvent({required this.userName});
}

class PasswordTFEvent extends LoginEvent {
  String password;
  PasswordTFEvent({required this.password});
}
