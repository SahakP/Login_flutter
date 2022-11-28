import 'package:bloc/bloc.dart';
import 'package:snap_chat_copy/model/country_model.dart';
import 'package:snap_chat_copy/repositiry/validation/validation_repository.dart';
import 'package:snap_chat_copy/services/Api/api_repo.dart';

import '../../../model/response_model.dart';
import '../../../utill/exepshon_map.dart';

part 'email_phone_event.dart';
part 'email_phone_state.dart';

Map<String, String> expMsg = ExpMap().expMsg;

class EmailPhoneBloc extends Bloc<EmailPhoneEvent, EmailPhoneState> {
  ValidationRepo validRepo;
  ApiRepo apiRepo;

  EmailPhoneBloc({required this.apiRepo, required this.validRepo})
      : super(EmailPhoneInitial()) {
    on<EmailEvent>(_onEmailEvent);
    on<EmailPhoneLoadCountresEvent>(_loadCountries);
    on<PhoneEvent>(_PhoneEvent);
  }

  Future<void> _onEmailEvent(EmailEvent event, Emitter emit) async {
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

  Future<void> _loadCountries(
      EmailPhoneLoadCountresEvent event, Emitter emitter) async {
    emitter(LoadinState());
    emitter(EmailPhoneLoadCountresState(
        countries: await ApiRepo().loadCountries(),
        currentLocation: await ApiRepo().loadLocation()));
  }
}
