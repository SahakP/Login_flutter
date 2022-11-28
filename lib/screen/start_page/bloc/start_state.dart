part of 'start_bloc.dart';

abstract class StartState {}

class StartInitial extends StartState {}

class RegistratedState extends StartState {
  User? user;
  RegistratedState({required this.user});
}

class NoUserState extends StartState {}
