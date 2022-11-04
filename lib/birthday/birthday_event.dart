part of 'birthday_bloc.dart';

abstract class BirthdayEvent {}

class BirthdayDataEvent extends BirthdayEvent {
  final DateTime validDate;

  BirthdayDataEvent({required this.validDate});
}
