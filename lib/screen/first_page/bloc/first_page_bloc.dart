import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snap_chat_copy/services/Api/api_service.dart';

import '../../../model/user_model.dart';
import '../../../repositiry/mongoDb/user_mongo_repo.dart';

part 'first_page_event.dart';
part 'first_page_state.dart';

class FirstPageBloc extends Bloc<FirstPageEvent, FirstPageState> {
  UserMongoRepo userRepo = UserMongoRepo();
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
      await userRepo.deleteUser(user);
      final token = tokenPref.remove('token');
    }
    emit(DeleteState());
  }
}
