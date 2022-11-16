import 'package:bloc/bloc.dart';
import 'package:snap_chat_copy/model/user_model.dart';
import 'package:snap_chat_copy/repositiry/user_repo.dart';
import 'package:snap_chat_copy/repositiry/validation_repository.dart';
import 'package:snap_chat_copy/utill/exepshon_map.dart';

import '../../services/api_service.dart';

part 'edit_event.dart';
part 'edit_state.dart';

var expMsg = ExpMap().expMsg;

class EditBloc extends Bloc<EditEvent, EditState> {
  final ApiService apiService;
  final UserRepo userRepo;
  final ValidationRepo validationRepo;

  EditBloc({
    required this.apiService,
    required this.userRepo,
    required this.validationRepo,
  }) : super(EdiiteInitial()) {
    on<EditUserEvent>(_EditUserEvent);
    on<BirthdayEvent>(_BirthdayEvent);
    on<CancelEvent>(_CancelEvent);
    on<LastNameEvent>(_LastNameEvent);
    on<FirstNameEvent>(_FirstNameEvent);
    on<NameEvent>(_NameEvent);
    on<PasswordEvent>(_PasswordEvent);
    on<EmailEvent>(_EmailEvent);
    on<PhoneEvent>(_PhoneEvent);
  }

  Future<void> _FirstNameEvent(FirstNameEvent event, Emitter emit) async {
    if (validationRepo.firstNameValidation(event.firstName!)) {
      emit(FirstNameState(isFirstNameValid: true));
    }
  }

  Future<void> _NameEvent(NameEvent event, Emitter emit) async {
    if (!validationRepo.nameValidation(event.name!)) {
      emit(NameValidationState(nameExpMsg: expMsg['nameValid']!));
    }
    if (!await apiService.checkName(event.name!)) {
      emit(NameCheckState(nameExpMsg: expMsg['nameCheck']!));
    }
    if (validationRepo.nameValidation(event.name!) &&
        await apiService.checkName(event.name!)) {
      emit(NameState(nameExpMsg: ''));
    }
  }

  Future<void> _PhoneEvent(PhoneEvent event, Emitter emit) async {
    if (!validationRepo.phoneValidation(event.phone!)) {
      emit(PhoneValidationState(phoneExpMsg: expMsg['phoneValid']!));
    }
    if (!await apiService.checkPhone(event.phone!)) {
      emit(PhoneCheckState(phoneExpMsg: expMsg['phoneCheck']!));
    }
    if (validationRepo.phoneValidation(event.phone!) &&
        await apiService.checkPhone(event.phone!)) {
      emit(PhoneState(phoneExpMsg: ''));
    }
  }

  Future<void> _PasswordEvent(PasswordEvent event, Emitter emit) async {
    if (validationRepo.passwordValidation(event.password)) {
      emit(PasswordState(isPassValid: true));
    }
  }

  Future<void> _EmailEvent(EmailEvent event, Emitter emit) async {
    if (!validationRepo.emailValidation(event.email!)) {
      emit(EmailValidationState(emailExpMsg: expMsg['emailValid']!));
    }
    if (!await apiService.checkEmail(event.email!)) {
      emit(EmailCheckState(emailExpMsg: expMsg['emailCheck']!));
    }
    if (validationRepo.emailValidation(event.email!) &&
        await apiService.checkEmail(event.email!)) {
      emit(EmailState(emailExpMsg: ''));
    }
  }

  Future<void> _LastNameEvent(LastNameEvent event, Emitter emit) async {
    if (validationRepo.lastNameValidation(event.lastName!)) {
      return emit(LastNameState(lastNameValid: true));
    } else {
      emit(LastNameState(lastNameValid: false));
    }
  }

  Future<void> _CancelEvent(CancelEvent event, Emitter emit) async {
    User? user;
    user = await apiService.getUser();
    if (user != null) {
      await apiService.deleteUser();
    }
    emit(CancelState());
  }

  Future<void> _BirthdayEvent(BirthdayEvent event, Emitter emit) async {
    if (validationRepo.birthdayValidation(DateTime.parse(event.birthday!))) {
      emit(BirthdayState(birthday: event.birthday, birthValid: true));
    } else {
      emit(BirthdayState(birthday: event.birthday, birthValid: false));
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
                if (await apiService.checkName(name))
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
                if (await apiService.checkPhone(phone)) {user.phone = phone}
              }
          }
        : null;
    email.isNotEmpty
        ? {
            if (validationRepo.emailValidation(email))
              {
                if (await apiService.checkEmail(email)) {user.email = email}
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
    final response = await apiService.editUer(user);
    emit(EditUserState(user: user));
  }
}
