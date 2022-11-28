import 'package:bloc/bloc.dart';
import 'package:snap_chat_copy/repositiry/validation/validation_repository.dart';
import 'package:snap_chat_copy/repositiry/Api/api_repo.dart';

import '../../../model/user_model.dart';
import '../../../repositiry/mongoDb/user_mongo_repo.dart';

part 'password_event.dart';
part 'password_state.dart';

class PasswordBloc extends Bloc<PasswordEvent, PasswordState> {
  ApiRepo apiRepo;
  UserMongoRepo userMongoRepo;
  ValidationRepo validRepo;
  PasswordBloc(
      {required this.validRepo,
      required this.apiRepo,
      required this.userMongoRepo})
      : super(PasswordInitial()) {
    on<PassEvent>(_onPassEvent);
    on<ButtonEvent>(_onButtonEvent);
  }

  Future<void> _onPassEvent(PassEvent event, Emitter emit) async {
    emit(PassState(
        IsPasswordValid: validRepo.passwordValidation(event.password)));
  }

  Future<void> _onButtonEvent(ButtonEvent event, Emitter emitter) async {
    await apiRepo.addUser(event.user);
    await userMongoRepo.createUser(event.user);
    emitter(PassDbState(user: event.user));
  }
}
