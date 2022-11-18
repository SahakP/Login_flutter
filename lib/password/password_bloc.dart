import 'package:bloc/bloc.dart';
import 'package:snap_chat_copy/repositiry/user_repo.dart';
import 'package:snap_chat_copy/repositiry/validation_repository.dart';
import 'package:snap_chat_copy/services/api_service.dart';

import '../model/user_model.dart';

part 'password_event.dart';
part 'password_state.dart';

class PasswordBloc extends Bloc<PasswordEvent, PasswordState> {
  ApiService apiService = ApiService();
  UserRepo userRepo = UserRepo();

  ValidationRepo validRepo = ValidationRepo();
  PasswordBloc({required this.validRepo}) : super(PasswordInitial()) {
    on<PassEvent>(_onPassEvent);
    on<ButtonEvent>(_onButtonEvent);
  }

  Future<void> _onPassEvent(PassEvent event, Emitter emit) async {
    emit(PassState(
        IsPasswordValid: validRepo.passwordValidation(event.password)));
  }

  Future<void> _onButtonEvent(ButtonEvent event, Emitter emitter) async {
    await apiService.addUser(event.user);
    await userRepo.createUser(event.user);
    await apiService.signin(event.user.name!, event.user.password!);
    emitter(PassDbState(user: event.user));
  }
}
