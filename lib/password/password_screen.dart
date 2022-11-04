import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization/localization.dart';
import 'package:snap_chat_copy/model/user_model.dart';
import 'package:snap_chat_copy/password/password_bloc.dart';
import 'package:snap_chat_copy/repositiry/user_repo.dart';
import 'package:snap_chat_copy/repositiry/validation_repository.dart';
import 'package:snap_chat_copy/widgets/back_button.dart';
import 'package:snap_chat_copy/widgets/button_submit.dart';
import 'package:snap_chat_copy/widgets/header.dart';
import 'package:snap_chat_copy/widgets/home.dart';
import 'package:snap_chat_copy/widgets/un_focused.dart';
import 'package:snap_chat_copy/widgets/under_text.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({required this.users, super.key});

  final User users;

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  UserRepo db = UserRepo();
  User? user;

  final _bloc = PasswordBloc(validRepo: ValidationRepo());
  bool isPasswordValid = false;
  TextEditingController controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => _bloc,
        child: BlocListener<PasswordBloc, PasswordState>(
          listener: _listener,
          child: BlocBuilder<PasswordBloc, PasswordState>(
            builder: _render,
          ),
        ));
  }

  Widget _render(context, state) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: UnFocusedWidget(
            child: Stack(children: [
          const BackBtn(blueWhite: true),
          Column(
            children: [
              Header(header: 'setAPassword'.i18n()),
              _renderUnderHeaderText(),
              _renderPasswordTF(),
              _renderUsernameErrorMsg(),
              _submitButton(),
            ],
          ),
        ])));
  }

  Widget _renderUnderHeaderText() {
    return UnderText(
      text: 'underPassHedTxt'.i18n(),
    );
  }

  Widget _renderUsernameErrorMsg() {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 40,
            vertical: 4,
          ),
          child: Text(
            !isPasswordValid ? 'passwordErrorMsg'.i18n() : '',
            style: const TextStyle(
                color: Color.fromARGB(255, 185, 193, 199),
                fontWeight: FontWeight.w700,
                fontSize: 12),
          ))
    ]);
  }

  Widget _renderPasswordTF() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 40,
        vertical: 2,
      ),
      child: TextField(
        autofocus: true,
        controller: controllerPassword,
        onChanged: (value) {
          _bloc.add(PassEvent(password: value));
        },
        style: const TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
        decoration: InputDecoration(
            labelText: 'password'.i18n(),
            labelStyle: const TextStyle(
              color: Color.fromARGB(255, 154, 160, 167),
            ),
            prefixStyle: const TextStyle(color: Colors.blue)),
      ),
    );
  }

  Widget _submitButton() {
    return Expanded(
        child: Align(
      alignment: FractionalOffset.bottomCenter,
      child: ButtonSubmit(
        isActive: isPasswordValid,
        title: 'Continue'.i18n(),
        onTap: () {
          widget.users.password = controllerPassword.text;
          _bloc.add(PassDbEvent(user: widget.users));
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const HomePage()));
        },
      ),
    ));
  }
}

extension _BlocListener on _PasswordScreenState {
  void _listener(context, state) {
    if (state is PassState) {
      isPasswordValid = state.IsPasswordValid;
    }
    if (state is PassDbState) {
      user = state.user;
      if (user != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
      }
    }
  }
}
