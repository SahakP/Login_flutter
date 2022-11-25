import 'package:bloc/bloc.dart';
import 'package:snap_chat_copy/model/user_model.dart';
import 'package:snap_chat_copy/repositiry/validation/validation_repository.dart';
import 'package:snap_chat_copy/utill/exepshon_map.dart';

import '../../../model/country_model.dart';
import '../../../model/response_model.dart';
import '../../../repositiry/mongoDb/country_mongo_repo.dart';
import '../../../repositiry/mongoDb/user_mongo_repo.dart';
import '../../../services/Api/api_repo.dart';

part 'edit_event.dart';
part 'edit_state.dart';

final expMsg = ExpMap().expMsg;

class EditBloc extends Bloc<EditEvent, EditState> {
  final ApiRepo apiRepo;
  final UserMongoRepo userMongoRepo;
  final CountryMongoRepo countryMongoRepo;
  final ValidationRepo validRepo;

  EditBloc(
      {required this.apiRepo,
      required this.userMongoRepo,
      required this.validRepo,
      required this.countryMongoRepo})
      : super(EdiiteInitial()) {
    on<EditUserEvent>(_EditUserEvent);
    on<BirthdayEvent>(_BirthdayEvent);
    on<CancelEvent>(_CancelEvent);
    on<LastNameEvent>(_LastNameEvent);
    on<FirstNameEvent>(_FirstNameEvent);
    on<NameEvent>(_NameEvent);
    on<PasswordEvent>(_PasswordEvent);
    on<EmailEvent>(_EmailEvent);
    on<PhoneEvent>(_PhoneEvent);
    on<CountriesEvent>(_CountriesEvent);
  }

  Future<void> _CountriesEvent(CountriesEvent event, Emitter emit) async {
    emit(LoadinState());
    emit(CountriesState(
        countries: await countryMongoRepo.getCountries(),
        currentLocation: await countryMongoRepo.getCountry()));
  }

  Future<void> _FirstNameEvent(FirstNameEvent event, Emitter emit) async {
    if (validRepo.firstNameValidation(event.firstName!)) {
      emit(FirstNameState(isFirstNameValid: true));
    }
  }

  Future<void> _NameEvent(NameEvent event, Emitter emit) async {
    ResponseModel? resModel;
    if (validRepo.nameValidation(event.name)) {
      resModel = await apiRepo.checkName(event.name);

      if (resModel.statusCode == 200) {
        emit(NameSuccessState(nameExpMsg: resModel.msg!, isNameValid: true));
      }
      if (resModel.statusCode == 500) {
        emit(NameCheckState(nameExpMsg: resModel.msg!, isNameValid: false));
      }
    } else {
      emit(
          NameCheckState(nameExpMsg: expMsg['nameValid']!, isNameValid: false));
    }
  }

  Future<void> _PhoneEvent(PhoneEvent event, Emitter emit) async {
    ResponseModel? resModel;
    if (validRepo.phoneValidation(event.phone)) {
      resModel = await apiRepo.checkPhone(event.phone);

      if (resModel.statusCode == 200) {
        emit(EmailSuccessState(emailExpMsg: resModel.msg!, isEmailValid: true));
      }
      if (resModel.statusCode == 500) {
        emit(EmailCheckState(emailExpMsg: resModel.msg!, isEmailValid: false));
      }
    } else {
      emit(EmailCheckState(
          emailExpMsg: expMsg['phoneValid']!, isEmailValid: false));
    }
  }

  Future<void> _PasswordEvent(PasswordEvent event, Emitter emit) async {
    if (validRepo.passwordValidation(event.password)) {
      emit(PasswordState(isPassValid: true));
    }
  }

  Future<void> _EmailEvent(EmailEvent event, Emitter emit) async {
    ResponseModel? resModel;
    if (validRepo.emailValidation(event.email)) {
      resModel = await apiRepo.checkEmail(event.email);

      if (resModel.statusCode == 200) {
        emit(EmailSuccessState(emailExpMsg: resModel.msg!, isEmailValid: true));
      }
      if (resModel.statusCode == 500) {
        emit(EmailCheckState(emailExpMsg: resModel.msg!, isEmailValid: false));
      }
    } else {
      emit(EmailCheckState(
          emailExpMsg: expMsg['emailValid']!, isEmailValid: false));
    }
  }

  Future<void> _LastNameEvent(LastNameEvent event, Emitter emit) async {
    if (validRepo.lastNameValidation(event.lastName!)) {
      return emit(LastNameState(lastNameValid: true));
    } else {
      emit(LastNameState(lastNameValid: false));
    }
  }

  Future<void> _CancelEvent(CancelEvent event, Emitter emit) async {
    User? user;
    user = await apiRepo.getUser();
    if (user != null) {
      await apiRepo.deleteUser();
    }
    emit(CancelState());
  }

  Future<void> _BirthdayEvent(BirthdayEvent event, Emitter emit) async {
    if (validRepo.birthdayValidation(DateTime.parse(event.birthday!))) {
      emit(BirthdayState(birthday: event.birthday, birthValid: true));
    } else {
      emit(BirthdayState(birthday: event.birthday, birthValid: false));
    }
  }

  Future<void> _EditUserEvent(EditUserEvent event, Emitter emit) async {
    //   final lastName = event.lastName;
    //   final firstName = event.firstName;
    //  // final name = event.name;
    //   final phone = event.phone;
    //   final email = event.email;
    //   final password = event.password;
    //   final birthday = event.birthday;
    //   final user = event.user;

    // lastName.isNotEmpty
    //     ? {
    //         if (validRepo.lastNameValidation(lastName))
    //           {user.lastName = lastName}
    //       }
    //     : null;

    // firstName.isNotEmpty
    //     ? {
    //         if (validRepo.firstNameValidation(firstName))
    //           {user.firstName = firstName}
    //       }
    //     : null;
    // name.isNotEmpty
    //     ? {
    //         if (validRepo.nameValidation(name))
    //           {
    //             if (await apiRepo.checkName(name).)
    //               {
    //                 user.name = name,
    //               }
    //           }
    //       }
    //     : null;
    // phone.isNotEmpty
    //     ? {
    //         if (validRepo.phoneValidation(phone))
    //           {
    //             if (await apiRepo.checkPhone(phone)) {user.phone = phone}
    //           }
    //       }
    //     : null;
    // email.isNotEmpty
    //     ? {
    //         if (validRepo.emailValidation(email))
    //           {
    //             if (await apiRepo.checkEmail(email)) {user.email = email}
    //           }
    //       }
    //     : null;
    // password.isNotEmpty
    //     ? {
    //         if (validRepo.passwordValidation(password))
    //           {user.password = password}
    //       }
    //     : null;
    // birthday.toString().isNotEmpty
    //     ? {
    //         if (validRepo.birthdayValidation(DateTime.parse(birthday)))
    //           {user.birthday = DateTime.parse(birthday)}
    //       }
    //     : null;

    await apiRepo.editUer(event.user);
    await userMongoRepo.updateUser(
        event.user,
        ({
          'naem': event.name,
          'firstName': event.firstName,
          'lastName': event.lastName,
          'password': event.password,
          'email': event.email,
          'phone': event.phone,
          'birthDate': event.user.birthday.toString(),
        }));
    emit(EditUserState(user: event.user));
  }
}
