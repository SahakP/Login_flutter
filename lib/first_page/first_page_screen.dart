import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization/localization.dart';
import 'package:snap_chat_copy/edite_user/edit_screen.dart';
import 'package:snap_chat_copy/utill/header.dart';

import '../model/user_model.dart';
import '../utill/home.dart';
import 'bloc/first_page_bloc.dart';

// ignore: must_be_immutable
class FirstPage extends StatefulWidget {
  FirstPage({required this.user, super.key});
  User user;

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final _bloc = FirstPageBloc();

  String get _validFormatDate {
    final formatter = DateFormat('dd MMMM yyyy');
    final birthday = formatter.format(widget.user.birthday!);
    return birthday;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => _bloc,
        child: BlocListener<FirstPageBloc, FirstPageState>(
          listener: _listener,
          child: BlocBuilder<FirstPageBloc, FirstPageState>(
            builder: _render,
          ),
        ));
  }

  Widget _render(BuildContext context, FirstPageState state) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Column(
              children: [
                Row(children: [
                  const Expanded(child: SizedBox()),
                  Header(
                    header: 'Welcome'.i18n(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40, left: 100),
                    child: _renderLogOutButton(),
                  ),
                ]),
                _renderLastName(),
                _renderFirstName(),
                _renderUsername(),
                _renderPhone(),
                _renderPassword(),
                _renderEmail(),
                _renderBDate(),
                const Expanded(
                  child: SizedBox(),
                ),
              ],
            ),
          ],
        ),
        bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _renderEditeButton(),
                  // const Expanded(child: SizedBox()),
                  _renderDeleteButton(),
                ])));
  }

  Widget _renderLastName() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          'lastName'.i18n() + ': ' + widget.user.lastName!,
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.w800, fontSize: 16),
        ),
      ),
    );
  }

  Widget _renderBDate() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          'BIRTHDAY'.i18n() + ': ' + _validFormatDate,
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.w800, fontSize: 16),
        ),
      ),
    );
  }

  Widget _renderFirstName() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          'firstName'.i18n() + ': ' + widget.user.firstName!,
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.w800, fontSize: 16),
        ),
      ),
    );
  }

  Widget _renderEmail() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          'EMAIL'.i18n() + ': ' + widget.user.email!,
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.w800, fontSize: 16),
        ),
      ),
    );
  }

  Widget _renderPhone() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          'MOBILENUMBER'.i18n() + ': ' + widget.user.phone!,
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.w800, fontSize: 16),
        ),
      ),
    );
  }

  Widget _renderUsername() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          'USERNAME'.i18n() + ': ' + widget.user.name!,
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.w800, fontSize: 16),
        ),
      ),
    );
  }

  Widget _renderPassword() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          'password'.i18n() + ': ' + widget.user.password!,
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.w800, fontSize: 16),
        ),
      ),
    );
  }

  Widget _renderLogOutButton() {
    return IconButton(
        onPressed: () {
          _bloc.add(LogoutEvent(user: widget.user));
        },
        icon: const Icon(Icons.logout_rounded));
  }

  Widget _renderEditeButton() {
    return ConstrainedBox(
      constraints: const BoxConstraints.tightFor(width: 120, height: 50),
      child: ElevatedButton(
        child: const Text(
          'EDITE',
          style: TextStyle(
            color: Colors.white,
            fontSize: 15.0,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 36, 174, 252),
        ),
        onPressed: () => _bloc.add(GoEditeEvent()),
      ),
    );
  }

  Widget _renderDeleteButton() {
    return ConstrainedBox(
      constraints: const BoxConstraints.tightFor(width: 120, height: 50),
      child: ElevatedButton(
        child: const Text(
          'DELETE',
          style: TextStyle(
            color: Colors.white,
            fontSize: 15.0,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 185, 193, 199),
        ),
        onPressed: () {
          _bloc.add(DeleteEvent());
        },
      ),
    );
  }
}

extension _BlocListener on _FirstPageState {
  void _listener(context, state) {
    if (state is LogoutState) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    }
    if (state is GoEditeState) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => EditePage(user: widget.user)));
    }
    if (state is DeleteState) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
      // Fluttertoast.showToast(msg: 'User deleted', gravity: ToastGravity.CENTER);
    }
  }
}
