import 'package:bloc/bloc.dart';
import 'package:snap_chat_copy/model/country_model.dart';
import 'package:snap_chat_copy/repositiry/validation/validation_repository.dart';
import 'package:snap_chat_copy/services/Api/api_service.dart';

import '../../../repositiry/sql/country_sql_repo.dart';
import '../../../utill/exepshon_map.dart';

part 'email_phone_event.dart';
part 'email_phone_state.dart';

var expMsg = ExpMap().expMsg;

class EmailPhoneBloc extends Bloc<EmailPhoneEvent, EmailPhoneState> {
  ValidationRepo validRepo = ValidationRepo();
  CountrySqlRepo countrySqlRepo = CountrySqlRepo();
  ApiService apiService = ApiService();

  EmailPhoneBloc({required this.countrySqlRepo, required this.validRepo})
      : super(EmailPhoneInitial()) {
    on<EmailEvent>(_onEmailEvent);
    on<EmailPhoneLoadCountresEvent>(_loadCountries);
    on<PhoneEvent>(_PhoneEvent);
  }

  Future<void> _onEmailEvent(EmailEvent event, Emitter emit) async {
    if (!validRepo.emailValidation(event.email)) {
      emit(EmailValidationState(emailExpMsg: expMsg['emailValid']!));
    }
    if (!await apiService.checkEmail(event.email)) {
      emit(EmailCheckState(emailExpMsg: expMsg['emailCheck']!));
    }
    if (validRepo.emailValidation(event.email) &&
        await apiService.checkEmail(event.email)) {
      emit(EmailState(emailExpMsg: ''));
    }
  }

  Future<void> _PhoneEvent(PhoneEvent event, Emitter emit) async {
    if (!validRepo.phoneValidation(event.phone)) {
      emit(PhoneValidationState(phoneExpMsg: expMsg['phoneValid']!));
    }
    if (!await apiService.checkPhone(event.phone)) {
      emit(PhoneCheckState(phoneExpMsg: expMsg['phoneCheck']!));
    }
    if (validRepo.phoneValidation(event.phone) &&
        await apiService.checkPhone(event.phone)) {
      emit(PhoneState(phoneExpMsg: ''));
    }
  }

  Future<void> _loadCountries(
      EmailPhoneLoadCountresEvent event, Emitter emitter) async {
    emitter(EmailPhoneLoadCountresState(
        countries: await countrySqlRepo.getCountries(),
        currentLocation: await countrySqlRepo.getCountry()));
  }
}
