import 'package:bloc/bloc.dart';
import 'package:snap_chat_copy/model/user_model.dart';
import 'package:snap_chat_copy/repositiry/user_repo.dart';
import 'package:snap_chat_copy/repositiry/validation_repository.dart';

import '../../repositiry/api_repo.dart';

part 'edite_event.dart';
part 'edite_state.dart';

class EditeBloc extends Bloc<EditeEvent, EditeState> {
  final ApiRepo apiRepo;
  final UserRepo userRepo;
  final ValidationRepo validationRepo;

  EditeBloc({
    required this.apiRepo,
    required this.userRepo,
    required this.validationRepo,
  }) : super(EdiiteInitial()) {
    on<LastNameEvent>(_LastNameEvent);
  }

  Future<void> _LastNameEvent(LastNameEvent event, Emitter emit) async {
    final lastName = event.lastName;
    final firstName = event.firstName;
    final name = event.name;
    final phone = event.phone;
    final email = event.email;
    var user = event.user;
    final password = event.password;

    lastName.isNotEmpty
        ? {
            if (validationRepo.lastNameValidation(lastName))
              {user.lastName = lastName}
          }
        : null;

    firstName.isNotEmpty
        ? {
            if (validationRepo.firstNameValidation(firstName))
              {user.firstName = firstName}
          }
        : null;
    name.isNotEmpty
        ? {
            if (validationRepo.nameValidation(name))
              {
                if (await apiRepo.checkName(name))
                  {
                    user.name = name,
                  }
              }
          }
        : null;
    phone.isNotEmpty
        ? {
            if (validationRepo.phoneValidation(phone))
              {
                if (await apiRepo.checkPhone(phone)) {user.phone = phone}
              }
          }
        : null;
    email.isNotEmpty
        ? {
            if (validationRepo.emailValidation(email))
              {
                if (await apiRepo.checkEmail(email)) {user.email = email}
              }
          }
        : null;
    password.isNotEmpty
        ? {
            if (validationRepo.passwordValidation(password))
              {user.password = password}
          }
        : null;
    await apiRepo.editUer(user);
    emit(EditUserState(user: user));
  }
}
