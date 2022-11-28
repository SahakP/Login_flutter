import 'package:bloc/bloc.dart';
import 'package:snap_chat_copy/repositiry/validation/validation_repository.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  ValidationRepo validRepo;
  SignUpBloc({required this.validRepo}) : super(SignUpInitial()) {
    on<FirstNameEvent>(_onFirstNameEvent);
    on<LastNameEvent>(_onLastNameEvent);
  }

  Future<void> _onFirstNameEvent(FirstNameEvent event, Emitter emitter) async {
    emitter(FiratNameState(
        isFirstNameValid: validRepo.firstNameValidation(event.firstName)));
  }

  Future<void> _onLastNameEvent(LastNameEvent event, Emitter emitter) async {
    emitter(LastNameState(
        isLastNameValid: validRepo.lastNameValidation(event.lastName)));
  }
}
