import 'package:bloc/bloc.dart';
import 'package:snap_chat_copy/repositiry/api_repo.dart';
import 'package:snap_chat_copy/repositiry/user_repo.dart';
import 'package:snap_chat_copy/repositiry/validation_repository.dart';

import '../model/user_model.dart';

part 'password_event.dart';
part 'password_state.dart';

class PasswordBloc extends Bloc<PasswordEvent, PasswordState> {
  ValidationRepo validRepo = ValidationRepo();
  PasswordBloc({required this.validRepo}) : super(PasswordInitial()) {
    on<PassEvent>(_onPassEvent);
    on<PassDbEvent>(_onPassDbEvent);
  }

  Future<void> _onPassEvent(PassEvent event, Emitter emit) async {
    emit(PassState(
        IsPasswordValid: validRepo.passwordValidation(event.password)));
  }

  Future<void> _onPassDbEvent(PassDbEvent event, Emitter emitter) async {
    UserRepo().createUser(event.user);
    ApiRepo().addUser(event.user);
    emitter(PassDbState(user: event.user));
  }
}
