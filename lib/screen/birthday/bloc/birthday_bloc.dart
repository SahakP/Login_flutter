import 'package:bloc/bloc.dart';
import 'package:snap_chat_copy/repositiry/validation/validation_repository.dart';

part 'birthday_event.dart';
part 'birthday_state.dart';

class BirthdayBloc extends Bloc<BirthdayEvent, BirthdayState> {
  ValidationRepo validRepo;
  BirthdayBloc({required this.validRepo}) : super(BirthdayInitial()) {
    on<BirthdayDataEvent>(_onBirthdayDataEvent);
  }

  Future<void> _onBirthdayDataEvent(
      BirthdayDataEvent event, Emitter emit) async {
    emit(BirthdayDataState(
        isDataValid: validRepo.birthdayValidation(event.validDate),
        validDate: event.validDate));
  }
}
