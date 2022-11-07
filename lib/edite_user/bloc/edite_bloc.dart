import 'package:bloc/bloc.dart';
import 'package:snap_chat_copy/model/user_model.dart';
import 'package:snap_chat_copy/repositiry/user_repo.dart';
import 'package:snap_chat_copy/repositiry/validation_repository.dart';

import '../../repositiry/api_repo.dart';

part 'edite_event.dart';
part 'edite_state.dart';

class EditeBloc extends Bloc<EditeEvent, EditeState> {
  final ApiRepo apiRepo;
  final UserRepo userRepo;
  final ValidationRepo validationRepo;

  EditeBloc({
    required this.apiRepo,
    required this.userRepo,
    required this.validationRepo,
  }) : super(EdiiteInitial()) {
    on<LastNameEvent>(_LastNameEvent);
  }

  Future<void> _LastNameEvent(LastNameEvent event, Emitter emit) async {
    final lastName = event.lastName;
    final firstName = event.firstName;
    final name = event.name;
    final phone = event.phone;
    final email = event.email;
    var user = event.user;

    lastName.isNotEmpty
        ? {
            if (validationRepo.nameValidation(lastName))
              {user.setLastName(lastName)}
          }
        : null;

    emit(LastNameState());
  }
}
