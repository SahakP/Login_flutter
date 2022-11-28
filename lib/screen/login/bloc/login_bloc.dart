import 'package:bloc/bloc.dart';
import 'package:flutter_mongodb_realm/realm_app.dart';
import 'package:snap_chat_copy/model/user_model.dart';
import 'package:snap_chat_copy/repositiry/validation/validation_repository.dart';
import 'package:snap_chat_copy/services/Api/api_repo.dart';

import '../../../repositiry/mongoDb/user_mongo_repo.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  ValidationRepo validRepo;
  ApiRepo apiRepo;
  UserMongoRepo userMongoRepo;

  LoginBloc(
      {required this.validRepo,
      required this.apiRepo,
      required this.userMongoRepo})
      : super(LoginInitialState()) {
    on<UserNameEvent>(_onUserNameEvent);

    on<PasswordTFEvent>(_onPasswordEvent);

    on<LogInButtonEvent>(_onLogInButtonEvent);
  }

  Future<void> _onUserNameEvent(UserNameEvent event, Emitter emit) async {
    emit(UserNameState(isNameValid: validRepo.nameValidation(event.userName)));
  }

  Future<void> _onPasswordEvent(PasswordTFEvent event, Emitter emit) async {
    emit(PasswordState(
        IsPasswordValid: validRepo.passwordValidation(event.password)));
  }

  Future<void> _onLogInButtonEvent(LogInButtonEvent event, Emitter emit) async {
    await RealmApp.init('application-0-tbwaj');
    final user = await apiRepo.signin(event.userName, event.password);
    await userMongoRepo.createUser(user!);

    emit(ButtonState(user: user));
  }
}
