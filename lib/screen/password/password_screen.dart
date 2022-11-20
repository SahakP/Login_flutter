import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization/localization.dart';
import 'package:snap_chat_copy/model/user_model.dart';
import 'package:snap_chat_copy/repositiry/validation/validation_repository.dart';
import 'package:snap_chat_copy/utill/back_button.dart';
import 'package:snap_chat_copy/utill/button_submit.dart';
import 'package:snap_chat_copy/utill/header.dart';
import 'package:snap_chat_copy/utill/home.dart';
import 'package:snap_chat_copy/utill/un_focused.dart';
import 'package:snap_chat_copy/utill/under_text.dart';

import '../../utill/exepshon_map.dart';
import '../first_page/first_page_screen.dart';
import 'bloc/password_bloc.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({required this.user, super.key});

  final User user;

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  //UserRepo db = UserRepo();
  User? user;
  var expMsg = ExpMap().expMsg;

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
              _renderPasswordErrorMsg(),
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

  Widget _renderPasswordErrorMsg() {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 40,
            vertical: 4,
          ),
          child: Text(
            !isPasswordValid ? expMsg['password']! : '',
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
          if (isPasswordValid) {
            widget.user.password = controllerPassword.text;
            _bloc.add(ButtonEvent(user: widget.user));
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const HomePage()));
          }
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
            context,
            MaterialPageRoute(
                builder: (context) => FirstPage(
                      user: widget.user,
                    )));
      }
    }
  }
}
