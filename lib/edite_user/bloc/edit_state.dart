part of 'edit_bloc.dart';

abstract class EditState {}

class EdiiteInitial extends EditState {}

class EditUserState extends EditState {
  User? user;
  EditUserState({required this.user});
}

class BirthdayState extends EditState {
  String? birthday;
  BirthdayState({required this.birthday});
}

class BackUserEditState extends EditState {}

class LastNameState extends EditState {
  bool lastNameValid;
  LastNameState({required this.lastNameValid});
}
