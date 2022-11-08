import 'package:bloc/bloc.dart';
import 'package:snap_chat_copy/model/user_model.dart';
import 'package:snap_chat_copy/repositiry/user_repo.dart';
import 'package:snap_chat_copy/repositiry/validation_repository.dart';

import '../../repositiry/api_repo.dart';

part 'edit_event.dart';
part 'edit_state.dart';

class EditBloc extends Bloc<EditEvent, EditState> {
  final ApiRepo apiRepo;
  final UserRepo userRepo;
  final ValidationRepo validationRepo;

  EditBloc({
    required this.apiRepo,
    required this.userRepo,
    required this.validationRepo,
  }) : super(EdiiteInitial()) {
    on<EditUserEvent>(_EditUserEvent);
    on<BirthdayEvent>(_BirthdayEvent);
    on<BackUserEditEvent>(_BackUserEditEvent);
    on<LastNameEvent>(_LastNameEvent);
  }

  Future<void> _LastNameEvent(LastNameEvent event, Emitter emit) async {
    if (validationRepo.lastNameValidation(event.lastName!)) {
      return emit(LastNameState(lastNameValid: true));
    } else {
      emit(LastNameState(lastNameValid: false));
    }
  }

  Future<void> _BackUserEditEvent(BackUserEditEvent event, Emitter emit) async {
    emit(BackUserEditState());
  }

  Future<void> _BirthdayEvent(BirthdayEvent event, Emitter emit) async {
    if (validationRepo.birthdayValidation(DateTime.parse(event.birthday!))) {
      emit(BirthdayState(birthday: event.birthday));
    }
  }

  Future<void> _EditUserEvent(EditUserEvent event, Emitter emit) async {
    final lastName = event.lastName;
    final firstName = event.firstName;
    final name = event.name;
    final phone = event.phone;
    final email = event.email;
    final password = event.password;
    final birthday = event.birthday;
    final user = event.user;

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
    birthday.toString().isNotEmpty
        ? {
            if (validationRepo.birthdayValidation(DateTime.parse(birthday)))
              {user.birthday = DateTime.parse(birthday)}
          }
        : null;
    final response = await apiRepo.editUer(user);
    emit(EditUserState(user: user));
  }
}
