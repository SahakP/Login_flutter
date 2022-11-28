import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snap_chat_copy/repositiry/Api/api_repo.dart';

import '../../../model/user_model.dart';

part 'start_event.dart';
part 'start_state.dart';

class StartBloc extends Bloc<StartEvent, StartState> {
  StartBloc() : super(StartInitial()) {
    on<IsRegEvent>(_isRegEvent);
  }

  Future<void> _isRegEvent(IsRegEvent event, Emitter emit) async {
    final tokenPref = await SharedPreferences.getInstance();
    final token = tokenPref.getString('token');

    if (token != null) {
      final user = await ApiRepo().getUser();
      emit(RegistratedState(user: user));
    } else {
      emit(NoUserState());
    }
  }
}
