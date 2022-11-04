import 'package:bloc/bloc.dart';
import 'package:snap_chat_copy/model/user_model.dart';
import 'package:snap_chat_copy/repositiry/api_repo.dart';
import 'package:snap_chat_copy/repositiry/user_repo.dart';
import 'package:snap_chat_copy/repositiry/validation_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  User user = User();
  User? findUser;
  ValidationRepo validRepo = ValidationRepo();
  ApiRepo apiRepo = ApiRepo();
  UserRepo userRepo = UserRepo();

  LoginBloc({required this.validRepo}) : super(LoginInitialState()) {
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
    final user = await apiRepo.signin(event.userName, event.password);

    emit(ButtonState(user: user));
  }
}


//await userRepo.getUser(event.userName, event.password)