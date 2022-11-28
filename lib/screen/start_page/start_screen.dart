import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snap_chat_copy/screen/start_page/bloc/start_bloc.dart';
import 'package:snap_chat_copy/repositiry/Api/api_repo.dart';
import 'package:snap_chat_copy/utill/home.dart';

import '../../model/user_model.dart';
import '../first_page/first_page_screen.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  final _bloc = StartBloc();
  ApiRepo apiRepo = ApiRepo();
  User? user;

  @override
  void initState() {
    _bloc.add(IsRegEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => _bloc,
        child: BlocListener<StartBloc, StartState>(
          listener: _listener,
          child: BlocBuilder<StartBloc, StartState>(
            builder: _render,
          ),
        ));
  }

  Widget _render(BuildContext context, StartState state) {
    return const Scaffold();
  }
}

extension _BlocListener on _StartPageState {
  void _listener(context, state) {
    if (state is RegistratedState) {
      user = state.user;
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => FirstPage(
                    user: user!,
                  )));
    }
    if (state is NoUserState) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    }
  }
}
