part of 'birthday_bloc.dart';

abstract class BirthdayState {}

class BirthdayInitial extends BirthdayState {}

class BirthdayDataState extends BirthdayState {
  bool isDataValid;
  final DateTime validDate;

  BirthdayDataState({required this.isDataValid, required this.validDate});
}
