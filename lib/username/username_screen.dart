import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization/localization.dart';
import 'package:snap_chat_copy/password/password_screen.dart';
import 'package:snap_chat_copy/repositiry/validation_repository.dart';
import 'package:snap_chat_copy/username/username_bloc.dart';
import 'package:snap_chat_copy/widgets/back_button.dart';
import 'package:snap_chat_copy/widgets/button_submit.dart';
import 'package:snap_chat_copy/widgets/header.dart';
import 'package:snap_chat_copy/widgets/un_focused.dart';
import 'package:snap_chat_copy/widgets/under_text.dart';

import '../model/user_model.dart';

class UsernameScreen extends StatefulWidget {
  const UsernameScreen({required this.users, super.key});
  final User users;
  @override
  State<UsernameScreen> createState() => _UsernameScreenState();
}

class _UsernameScreenState extends State<UsernameScreen> {
  final _bloc = UsernameBloc(validRepo: ValidationRepo());
  bool isUserValid = false;
  TextEditingController controllerUsername = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => _bloc,
        child: BlocListener<UsernameBloc, UsernameState>(
          listener: _listener,
          child: BlocBuilder<UsernameBloc, UsernameState>(
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
              Header(
                header: 'pickAUsername'.i18n(),
              ),
              _renderUnderHeaderText(),
              _renderUsernameTF(),
              _renderUsernameErrorMsg(),
              _submitButton(),
            ],
          ),
        ])));
  }

  Widget _renderUnderHeaderText() {
    return UnderText(
      text: 'underHederText'.i18n(),
    );
  }

  Widget _renderUsernameErrorMsg() {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 40,
            vertical: 8,
          ),
          child: Text(
            !isUserValid ? 'userNameErrorMsg'.i18n() : '',
            style: const TextStyle(
                color: Color.fromARGB(255, 185, 193, 199),
                fontWeight: FontWeight.w700,
                fontSize: 12),
          ))
    ]);
  }

  Widget _renderUsernameTF() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 40,
        vertical: 2,
      ),
      child: TextField(
        autofocus: true,
        controller: controllerUsername,
        onChanged: (value) {
          _bloc.add(UsernaemEvent(name: value));
        },
        style: const TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
        decoration: InputDecoration(
            labelText: 'USERNAME'.i18n(),
            prefixStyle: const TextStyle(color: Colors.blue)),
      ),
    );
  }

  Widget _submitButton() {
    return Expanded(
        child: Align(
      alignment: FractionalOffset.bottomCenter,
      child: ButtonSubmit(
        isActive: isUserValid,
        title: 'Continue'.i18n(),
        onTap: () {
          widget.users.name = controllerUsername.text;
          isUserValid
              ? Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          PasswordScreen(users: widget.users)))
              : null;
        },
      ),
    ));
  }
}

extension _BlocListener on _UsernameScreenState {
  void _listener(context, state) {
    if (state is UsernaemState) {
      isUserValid = state.isUsernameValid;
    }
  }
}
