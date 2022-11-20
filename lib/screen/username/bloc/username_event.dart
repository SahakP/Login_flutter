part of 'username_bloc.dart';

abstract class UsernameEvent {}

class NameEvent extends UsernameEvent {
  final String name;
  NameEvent({required this.name});
}
