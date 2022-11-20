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
  bool birthValid;
  BirthdayState({required this.birthday, required this.birthValid});
}

class LastNameState extends EditState {
  bool lastNameValid;
  LastNameState({required this.lastNameValid});
}

class OkButtonState extends EditState {}

class FirstNameState extends EditState {
  bool isFirstNameValid;
  FirstNameState({required this.isFirstNameValid});
}

class NameValidationState extends EditState {
  String nameExpMsg;
  NameValidationState({required this.nameExpMsg});
}

class NameState extends EditState {
  String nameExpMsg;
  NameState({required this.nameExpMsg});
}

class NameCheckState extends EditState {
  String nameExpMsg;
  NameCheckState({required this.nameExpMsg});
}

class PhoneState extends EditState {
  String phoneExpMsg;
  PhoneState({required this.phoneExpMsg});
}

class PhoneValidationState extends EditState {
  String phoneExpMsg;
  PhoneValidationState({required this.phoneExpMsg});
}

class PhoneCheckState extends EditState {
  String phoneExpMsg;
  PhoneCheckState({required this.phoneExpMsg});
}

class PasswordState extends EditState {
  bool isPassValid;
  PasswordState({required this.isPassValid});
}

class EmailState extends EditState {
  String emailExpMsg;
  EmailState({required this.emailExpMsg});
}

class EmailValidationState extends EditState {
  String emailExpMsg;
  EmailValidationState({required this.emailExpMsg});
}

class EmailCheckState extends EditState {
  String emailExpMsg;
  EmailCheckState({required this.emailExpMsg});
}
