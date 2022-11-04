import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization/localization.dart';
import 'package:snap_chat_copy/repositiry/validation_repository.dart';
import 'package:snap_chat_copy/signup/bloc/sign_up_bloc.dart';
import 'package:snap_chat_copy/widgets/back_button.dart';
import 'package:snap_chat_copy/widgets/button_submit.dart';
import 'package:snap_chat_copy/widgets/header.dart';
import 'package:snap_chat_copy/widgets/un_focused.dart';

import '../../birthday/birthday_screen.dart';
import '../../model/user_model.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // late SqliteService _sqliteService;
  // List<User> _users = [];

  // @override
  // void initState() {
  //   super.initState();
  //   this._sqliteService = SqliteService();
  //   this._sqliteService.initializeDB().whenComplete(() async {
  //     await _refreshUsers();
  //     setState(() {});
  //   });
  // }

  // Future<void> _refreshUsers() async {
  //   final data = await SqliteService().getUsers();
  //   setState(() {
  //     _users = data;
  //   });
  // }

  final _bloc = SignUpBloc(validRepo: ValidationRepo());

  bool firstNameValid = false;
  bool lastNaemValid = false;

  final controllerFirstName = TextEditingController();
  final controllerLastName = TextEditingController();

  User user = User();

  @override
  void dispose() {
    controllerFirstName.dispose();
    controllerLastName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => _bloc,
        child: BlocListener<SignUpBloc, SignUpState>(
          listener: _listener,
          child: BlocBuilder<SignUpBloc, SignUpState>(
            builder: _render,
          ),
        ));
  }

  Widget _render(context, state) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: UnFocusedWidget(
          child: Stack(
            children: [
              const BackBtn(blueWhite: true), //SingleChildScrollView
              Column(
                children: [
                  Header(header: 'whatsYoureName'.i18n()),
                  _renderFirstNameTF(),
                  _renderFirstNameErrorMsg(),
                  _renderLastNameTF(),
                  _renderLastNameErrorMsg(),
                  _renderLinks(),
                  _signUpButton(),
                ],
              )
            ],
          ),
        ));
  }

  Widget _renderFirstNameErrorMsg() {
    if (!firstNameValid) {
      return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 60,
              vertical: 2,
            ),
            child: Text(
              'usernaemErrorMsg'.i18n(),
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

  Widget _renderFirstNameTF() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 60,
        vertical: 0,
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 0),
        child: TextField(
          autofocus: true,
          controller: controllerFirstName,
          onChanged: (value) {
            _bloc.add(FirstNameEvent(firstName: value));
          },
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.w700, fontSize: 12),
          decoration: InputDecoration(
            labelText: 'firstName'.i18n(),
          ),
        ),
      ),
    );
  }

  Widget _renderLastNameErrorMsg() {
    if (!lastNaemValid) {
      return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 60,
              vertical: 2,
            ),
            child: Text(
              'usernaemErrorMsg'.i18n(),
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

  Widget _renderLastNameTF() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 60,
        vertical: 0,
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 0),
        child: TextField(
          controller: controllerLastName,
          onChanged: (value) {
            _bloc.add(LastNameEvent(lastName: value));
            setState(() {});
          },
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.w700, fontSize: 12),
          decoration: InputDecoration(labelText: 'lastName'.i18n()),
        ),
      ),
    );
  }

  Widget _renderLinks() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 62),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(color: Colors.black, fontSize: 13),
          children: <TextSpan>[
            TextSpan(
                text: 'textSpan1'.i18n(),
                style: const TextStyle(color: Colors.black)),
            TextSpan(
                text: 'textSpan2'.i18n(),
                style: const TextStyle(color: Colors.blue)),
            TextSpan(
                text: 'textSpan3'.i18n(),
                style: const TextStyle(color: Colors.black)),
            TextSpan(
                text: 'textSpan4'.i18n(),
                style: const TextStyle(color: Colors.blue)),
          ],
        ),
      ),
    );
  }

  Widget _signUpButton() {
    return Expanded(
        child: Align(
      alignment: FractionalOffset.bottomCenter,
      child: ButtonSubmit(
        isActive: _isActive,
        title: 'signUpAccept'.i18n(),
        onTap: () {
          user
            ..firstName = controllerFirstName.text
            ..lastName = controllerLastName.text;
          if (_isActive) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BirthdayScreen(user: user)));
          }
        },
      ),
    ));
  }

  // bool get _firstNameValidation {
  //   return controllerFirstName.text.isNotEmpty;
  // }

  // bool get _lastNameValidation {
  //   return controllerLastName.text.isNotEmpty;
  // }

  bool get _isActive {
    if (firstNameValid && lastNaemValid) {
      return true;
    } else {
      return false;
    }
  }
}

extension _BlocListener on _SignUpScreenState {
  void _listener(context, state) {
    if (state is FiratNameState) {
      firstNameValid = state.isFirstNameValid;
    }
    if (state is LastNameState) {
      lastNaemValid = state.isLastNameValid;
    }
  }
}
