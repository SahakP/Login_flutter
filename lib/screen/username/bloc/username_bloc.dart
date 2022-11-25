import 'package:bloc/bloc.dart';
import 'package:snap_chat_copy/model/response_model.dart';
import 'package:snap_chat_copy/repositiry/validation/validation_repository.dart';
import 'package:snap_chat_copy/services/Api/api_repo.dart';

import '../../../utill/exepshon_map.dart';

part 'username_event.dart';
part 'username_state.dart';

var expMsg = ExpMap().expMsg;

class UsernameBloc extends Bloc<UsernameEvent, UsernameState> {
  ValidationRepo validRepo;
  ApiRepo apiRepo;
  UsernameBloc({required this.validRepo, required this.apiRepo})
      : super(UsernameInitial()) {
    on<NameEvent>(_NameEvent);
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
}
