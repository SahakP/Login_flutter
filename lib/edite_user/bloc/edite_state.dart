part of 'edite_bloc.dart';

abstract class EditeState {}

class EdiiteInitial extends EditeState {}

class EditUserState extends EditeState {
  User? user;
  EditUserState({required this.user});
}
