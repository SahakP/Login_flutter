part of 'start_bloc.dart';

abstract class StartState {}

class StartInitial extends StartState {}

class IsRegState extends StartState {
  final bool isReg;
  User? user;
  IsRegState({required this.isReg, required this.user});
}
