part of 'username_bloc.dart';

abstract class UsernameEvent {}

class UsernaemEvent extends UsernameEvent {
  final String name;
  UsernaemEvent({required this.name});
}
