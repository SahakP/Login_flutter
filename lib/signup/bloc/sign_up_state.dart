part of 'sign_up_bloc.dart';

abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class FiratNameState extends SignUpState {
  final bool isFirstNameValid;
  FiratNameState({required this.isFirstNameValid});
}

class LastNameState extends SignUpState {
  final bool isLastNameValid;
  LastNameState({required this.isLastNameValid});
}
