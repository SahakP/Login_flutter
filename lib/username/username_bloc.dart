import 'package:bloc/bloc.dart';
import 'package:snap_chat_copy/repositiry/validation_repository.dart';
import 'package:snap_chat_copy/services/api_service.dart';

import '../utill/exepshon_map.dart';

part 'username_event.dart';
part 'username_state.dart';

var expMsg = ExpMap().expMsg;

class UsernameBloc extends Bloc<UsernameEvent, UsernameState> {
  ValidationRepo validRepo = ValidationRepo();
  ApiService apiService = ApiService();
  UsernameBloc({required this.validRepo}) : super(UsernameInitial()) {
    on<NameEvent>(_NameEvent);
  }

  Future<void> _NameEvent(NameEvent event, Emitter emit) async {
    if (!validRepo.nameValidation(event.name)) {
      emit(NameValidationState(nameExpMsg: expMsg['nameValid']!));
    }
    if (!await apiService.checkName(event.name)) {
      emit(NameCheckState(nameExpMsg: expMsg['nameCheck']!));
    }
    if (validRepo.nameValidation(event.name) &&
        await apiService.checkName(event.name)) {
      emit(NameState(nameExpMsg: ''));
    }
  }
}
