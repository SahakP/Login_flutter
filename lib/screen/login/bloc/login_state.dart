part of 'login_bloc.dart';

abstract class LoginState {}

class LoginInitialState extends LoginState {}

class UserNameState extends LoginState {
  final bool isNameValid;
  UserNameState({required this.isNameValid});
}

class PasswordState extends LoginState {
  final bool IsPasswordValid;
  PasswordState({required this.IsPasswordValid});
}

class ButtonState extends LoginState {
  final User? user;
  ButtonState({required this.user});
}
