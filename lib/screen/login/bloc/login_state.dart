part of 'login_bloc.dart';

abstract class LoginState {}

class LoginInitialState extends LoginState {}

class UserNameState extends LoginState {
  bool isNameValid;
  UserNameState({required this.isNameValid});
}

class PasswordState extends LoginState {
  bool IsPasswordValid;
  PasswordState({required this.IsPasswordValid});
}

class ButtonState extends LoginState {
  User? user;
  ButtonState({required this.user});
}
