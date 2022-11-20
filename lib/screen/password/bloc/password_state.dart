part of 'password_bloc.dart';

abstract class PasswordState {}

class PasswordInitial extends PasswordState {}

class PassState extends PasswordState {
  final bool IsPasswordValid;
  PassState({required this.IsPasswordValid});
}

class PassDbState extends PasswordState {
  User? user;
  PassDbState({required this.user});
}
