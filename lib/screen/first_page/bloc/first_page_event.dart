part of 'first_page_bloc.dart';

abstract class FirstPageEvent {}

class LogoutEvent extends FirstPageEvent {
  User user;
  LogoutEvent({required this.user});
}

class GoEditeEvent extends FirstPageEvent {}

class DeleteEvent extends FirstPageEvent {}

class LoadingEvent extends FirstPageEvent {}
