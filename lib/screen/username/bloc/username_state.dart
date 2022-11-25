part of 'username_bloc.dart';

abstract class UsernameState {}

class UsernameInitial extends UsernameState {}

class NameSuccessState extends UsernameState {
  String nameExpMsg;
  bool isNameValid;
  NameSuccessState({required this.nameExpMsg, required this.isNameValid});
}

class NameCheckState extends UsernameState {
  bool isNameValid;
  String nameExpMsg;
  NameCheckState({required this.nameExpMsg, required this.isNameValid});
}
