import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snap_chat_copy/repositiry/user_repo.dart';

import '../../model/user_model.dart';

part 'first_page_event.dart';
part 'first_page_state.dart';

class FirstPageBloc extends Bloc<FirstPageEvent, FirstPageState> {
  UserRepo userRepo = UserRepo();

  FirstPageBloc() : super(FirstPageInitial()) {
    on<LogoutEvent>(_LogoutEvent);
  }

  Future<void> _LogoutEvent(LogoutEvent event, Emitter emit) async {
    final tokenPref = await SharedPreferences.getInstance();
    final token = tokenPref.remove('token');
    await userRepo.getUser(event.user.name!, event.user.password!);
    emit(LogoutState());
  }
}
