import 'package:bloc/bloc.dart';
import 'package:snap_chat_copy/repositiry/validation_repository.dart';

part 'birthday_event.dart';
part 'birthday_state.dart';

late DateTime data;
// late String tFData;

class BirthdayBloc extends Bloc<BirthdayEvent, BirthdayState> {
  ValidationRepo validRepo = ValidationRepo();
  BirthdayBloc({required this.validRepo}) : super(BirthdayInitial()) {
    on<BirthdayDataEvent>(_onBirthdayDataEvent);
  }

  Future<void> _onBirthdayDataEvent(
      BirthdayDataEvent event, Emitter emit) async {
    emit(BirthdayDataState(
        isDataValid: validRepo.birthdayValid(event.validDate),
        validDate: event.validDate));
  }
}
