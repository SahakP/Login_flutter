import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snap_chat_copy/repositiry/user_repo.dart';
import 'package:snap_chat_copy/services/api_service.dart';

import '../../model/user_model.dart';

part 'first_page_event.dart';
part 'first_page_state.dart';

class FirstPageBloc extends Bloc<FirstPageEvent, FirstPageState> {
  UserRepo userRepo = UserRepo();
  ApiService apiRepo = ApiService();

  FirstPageBloc() : super(FirstPageInitial()) {
    on<LogoutEvent>(_LogoutEvent);
    on<GoEditeEvent>(_EditeEvent);
    on<DeleteEvent>(_DeleteEvent);
  }

  Future<void> _LogoutEvent(LogoutEvent event, Emitter emit) async {
    final tokenPref = await SharedPreferences.getInstance();
    final token = tokenPref.remove('token');
    emit(LogoutState());
  }

  Future<void> _EditeEvent(GoEditeEvent event, Emitter emit) async {
    emit(GoEditeState());
  }

  Future<void> _DeleteEvent(DeleteEvent event, Emitter emit) async {
    final tokenPref = await SharedPreferences.getInstance();

    User? user;
    user = await apiRepo.getUser();
    if (user != null) {
      await apiRepo.deleteUser();
      final token = tokenPref.remove('token');
      //TODO:    userRepo.delete(user.name!);
    }
    emit(DeleteState());
  }
}
