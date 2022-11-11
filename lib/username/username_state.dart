part of 'username_bloc.dart';

abstract class UsernameState {}

class UsernameInitial extends UsernameState {}

class NameValidationState extends UsernameState {
  String nameExpMsg;
  NameValidationState({required this.nameExpMsg});
}

class NameState extends UsernameState {
  String nameExpMsg;
  NameState({required this.nameExpMsg});
}

class NameCheckState extends UsernameState {
  String nameExpMsg;
  NameCheckState({required this.nameExpMsg});
}
