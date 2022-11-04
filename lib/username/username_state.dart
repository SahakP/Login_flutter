part of 'username_bloc.dart';

abstract class UsernameState {}

class UsernameInitial extends UsernameState {}

class UsernaemState extends UsernameState {
  bool isUsernameValid;
  UsernaemState({required this.isUsernameValid});
}
