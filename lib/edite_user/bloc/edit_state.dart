part of 'edit_bloc.dart';

abstract class EditState {}

class EdiiteInitial extends EditState {}

class EditUserState extends EditState {
  User? user;
  EditUserState({required this.user});
}

class CancelState extends EditState {}

class BirthdayState extends EditState {
  String? birthday;
  BirthdayState({required this.birthday});
}

class LastNameState extends EditState {
  bool lastNameValid;
  LastNameState({required this.lastNameValid});
}
