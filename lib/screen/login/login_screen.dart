import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization/localization.dart';
import 'package:snap_chat_copy/repositiry/validation/validation_repository.dart';
import 'package:snap_chat_copy/utill/back_button.dart';
import 'package:snap_chat_copy/utill/header.dart';
import 'package:snap_chat_copy/utill/un_focused.dart';

import '../../utill/button_submit.dart';
import '../../utill/exepshon_map.dart';
import '../first_page/first_page_screen.dart';
import 'bloc/login_bloc.dart';

class LoginScren extends StatefulWidget {
  const LoginScren({super.key});

  @override
  State<LoginScren> createState() => _LoginScrenState();
}

class _LoginScrenState extends State<LoginScren> {
  final _bloc = LoginBloc(validRepo: ValidationRepo());

  TextEditingController controllerPassword = TextEditingController();

  TextEditingController controllerUsername = TextEditingController();

  bool _isNameValid = false;
  bool _isPasswordValid = false;
  var expMsg = ExpMap().expMsg;

  bool isLoginButtonActive = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => _bloc,
        child: BlocListener<LoginBloc, LoginState>(
          listener: _listener,
          child: BlocBuilder<LoginBloc, LoginState>(
            builder: _render,
          ),
        ));
  }

  Widget _render(BuildContext context, LoginState state) {
    // MyLocalizations? localization = MyLocalizations.of(context);
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: UnFocusedWidget(
          child: Stack(
            children: [
              const BackBtn(blueWhite: true),
              Column(
                children: [
                  Header(
                    header: 'login'.i18n(),
                  ),
                  _renderUserNameTF(),
                  _renderNameErrorMsg(),
                  _renderPasswordTF(),
                  _renderPasswordErrorMsg(),
                  _renderLink(),
                  _rederLogInButton(),
                ],
              ),
            ],
          ),
        ));
  }

  Widget _renderUserNameTF() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 40,
        vertical: 0,
      ),
      child: TextField(
        autofocus: true,
        controller: controllerUsername,
        onChanged: (value) {
          _bloc.add(UserNameEvent(userName: value));
        },
        style: const TextStyle(
            color: Colors.black, fontWeight: FontWeight.w700, fontSize: 12),
        decoration: InputDecoration(
            labelText: 'usernaemOrEmail'.i18n(),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 0, vertical: 10)),
      ),
    );
  }

  Widget _renderNameErrorMsg() {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 40,
            vertical: 4,
          ),
          child: Text(
            !_isNameValid ? 'usernaemErrorMsg'.i18n() : '',
            //MyLocalizations.of(context)!.usernaemErrorMsg!,
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
        vertical: 0,
      ),
      child: TextField(
        controller: controllerPassword,
        onChanged: (value) {
          _bloc.add(PasswordTFEvent(password: value));
        },
        obscuringCharacter: '*',
        obscureText: true,
        style: const TextStyle(
            color: Colors.black, fontWeight: FontWeight.w700, fontSize: 12),
        decoration: InputDecoration(
            labelText: 'password'.i18n(),
            //MyLocalizations.of(context)!.password,
            suffixIcon: const Icon(Icons.visibility_off_sharp),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 0, vertical: 10)),
      ),
    );
  }

  Widget _renderPasswordErrorMsg() {
    if (!_isPasswordValid) {
      return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 4,
            ),
            child: Text(
              'passwordErrorMsg'.i18n(),
              // MyLocalizations.of(context)!.passwordErrorMsg!,
              style: const TextStyle(
                  color: Color.fromARGB(255, 185, 193, 199),
                  fontWeight: FontWeight.w700,
                  fontSize: 12),
            ))
      ]);
    } else {
      return const Text('');
    }
  }

  Widget _renderLink() {
    return TextButton(
        onPressed: () {},
        child: Text(
          'forgotYourPassword'.i18n(),
          //MyLocalizations.of(context)!.forgotYourPassword!,
          style: const TextStyle(
              color: Color.fromARGB(255, 21, 126, 251), fontSize: 12),
        ));
  }

  Widget _rederLogInButton() {
    return Expanded(
        child: Align(
      alignment: FractionalOffset.bottomCenter,
      child: ButtonSubmit(
        isActive: _isValid,
        title: 'login'.i18n(),
        onTap: () {
          _bloc.add(LogInButtonEvent(
              password: controllerPassword.text,
              userName: controllerUsername.text));
        },
      ),
    ));
  }

  bool get _isValid {
    return _isNameValid && _isPasswordValid;
  }

  void showAlertDialog() {
    final Widget okButton = TextButton(
      child: Text(
        'ok'.i18n(),
        style: const TextStyle(color: Colors.black),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    final alert = AlertDialog(
      title: Text('userNotFound'.i18n(),
          style: const TextStyle(color: Color.fromARGB(255, 200, 53, 50))),
      content: Text('tryEnterCorrectData'.i18n()),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

extension _BlocListener on _LoginScrenState {
  void _listener(context, state) {
    if (state is UserNameState) {
      _isNameValid = state.isNameValid;
    }

    if (state is PasswordState) {
      _isPasswordValid = state.IsPasswordValid;
    }

    if (state is ButtonState) {
      final findUser = state.user;

      if (_isValid) {
        if (findUser != null) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => FirstPage(
                        user: findUser,
                      )));
        } else {
          showAlertDialog();
        }
      }
    }
  }
}
