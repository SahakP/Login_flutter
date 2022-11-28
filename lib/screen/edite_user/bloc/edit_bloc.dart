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

Map<String, String> expMsg = ExpMap().expMsg;
ResponseModel? resModel;

class EditBloc extends Bloc<EditEvent, EditState> {
  ApiRepo apiRepo;
  UserMongoRepo userMongoRepo;
  CountryMongoRepo countryMongoRepo;
  ValidationRepo validRepo;

  EditBloc(
      {required this.apiRepo,
      required this.userMongoRepo,
      required this.validRepo,
      required this.countryMongoRepo})
      : super(EdiiteInitial()) {
    on<SaveUserEvent>(_SaveUserEvent);
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
        emit(PhoneSuccessState(phoneExpMsg: resModel.msg!, isPhoneValid: true));
      }
      if (resModel.statusCode == 500) {
        emit(PhoneCheckState(phoneExpMsg: resModel.msg!, isPhoneValid: false));
      }
    } else {
      emit(PhoneCheckState(
          phoneExpMsg: expMsg['phoneValid']!, isPhoneValid: false));
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
      emit(LastNameState(lastNameValid: true));
    } else {
      emit(LastNameState(lastNameValid: false));
    }
  }

  Future<void> _CancelEvent(CancelEvent event, Emitter emit) async {
    emit(CancelState());
  }

  Future<void> _BirthdayEvent(BirthdayEvent event, Emitter emit) async {
    if (validRepo.birthdayValidation(DateTime.parse(event.birthday!))) {
      emit(BirthdayState(birthday: event.birthday, birthValid: true));
    } else {
      emit(BirthdayState(birthday: event.birthday, birthValid: false));
    }
  }

  Future<void> _SaveUserEvent(SaveUserEvent event, Emitter emit) async {
    final lastName = event.lastName;
    final firstName = event.firstName;
    final name = event.name;
    final phone = event.phone;
    final email = event.email;
    final password = event.password;
    final birthday = event.birthday;
    final user = event.user;

    lastName!.isNotEmpty
        ? {
            if (validRepo.lastNameValidation(lastName))
              {user.lastName = lastName}
          }
        : null;

    firstName!.isNotEmpty
        ? {
            if (validRepo.firstNameValidation(firstName))
              {user.firstName = firstName}
          }
        : null;
    name!.isNotEmpty
        ? {
            if (validRepo.nameValidation(name))
              {
                resModel = await apiRepo.checkName(name),
                if (resModel?.statusCode == 200)
                  {
                    user.name = name,
                  }
              }
          }
        : null;
    phone!.isNotEmpty
        ? {
            if (validRepo.phoneValidation(phone))
              {
                resModel = await apiRepo.checkPhone(phone),
                if (resModel?.statusCode == 200) {user.phone = phone}
              }
          }
        : null;
    email!.isNotEmpty
        ? {
            if (validRepo.emailValidation(email))
              {
                resModel = await apiRepo.checkEmail(email),
                if (resModel?.statusCode == 200) {user.email = email}
              }
          }
        : null;
    password!.isNotEmpty
        ? {
            if (validRepo.passwordValidation(password))
              {user.password = password}
          }
        : null;
    birthday.toString().isNotEmpty
        ? {
            if (validRepo.birthdayValidation(DateTime.parse(birthday!)))
              {user.birthday = DateTime.parse(birthday)}
          }
        : null;

    await apiRepo.editUer(event.user);
    await userMongoRepo.updateUser(
        event.user,
        ({
          'naem': name,
          'firstName': firstName,
          'lastName': lastName,
          'password': password,
          'email': email,
          'phone': phone,
          'birthDate': user.birthday.toString(),
        }));
    emit(SaveUserState(user: user));
  }
}
