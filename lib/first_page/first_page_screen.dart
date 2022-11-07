import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization/localization.dart';
import 'package:snap_chat_copy/edite_user/edite_screen.dart';
import 'package:snap_chat_copy/widgets/header.dart';

import '../model/user_model.dart';
import '../widgets/home.dart';
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
              Row(children: [
                _renderEditeButton(),
                const Expanded(child: SizedBox()),
                _renderDeleteButton(),
              ])
            ],
          ),
        ],
      ),
    );
  }

  Widget _renderLastName() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          'Last naem: ' + widget.user.lastName!,
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.w800, fontSize: 18),
        ),
      ),
    );
  }

  Widget _renderBDate() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          'Birth date: ' + _validFormatDate,
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.w800, fontSize: 18),
        ),
      ),
    );
  }

  Widget _renderFirstName() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          'First name: ' + widget.user.firstName!,
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.w800, fontSize: 18),
        ),
      ),

      // child: Column(
      //   children: [
      //     Padding(
      //         padding: const EdgeInsets.symmetric(
      //           horizontal: 40,
      //           vertical: 0,
      //         ),
      //         child: TextField(
      //           readOnly: true,
      //           // autofocus: true,
      //           // controller: controllerUsername,
      //           onChanged: (value) {},
      //           style: const TextStyle(
      //               color: Colors.black,
      //               fontWeight: FontWeight.w800,
      //               fontSize: 16),
      //           decoration: InputDecoration(
      //               hintText: 'First name: ' + widget.user.firstName!,
      //               contentPadding: const EdgeInsets.symmetric(
      //                   horizontal: 0, vertical: 10)),
      //         )),
      //   ],
      // ),
    );
  }

  Widget _renderEmail() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          'Email: ' + widget.user.email!,
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.w800, fontSize: 18),
        ),
      ),
      // child: Column(
      //   children: [
      //     Padding(
      //         padding: const EdgeInsets.symmetric(
      //           horizontal: 40,
      //           vertical: 0,
      //         ),
      //         child: TextField(
      //           readOnly: true,
      //           // autofocus: true,
      //           // controller: controllerUsername,
      //           onChanged: (value) {},
      //           style: const TextStyle(
      //               color: Colors.black,
      //               fontWeight: FontWeight.w800,
      //               fontSize: 16),
      //           decoration: InputDecoration(
      //               hintText: 'Email: ' + widget.user.email!,
      //               contentPadding: const EdgeInsets.symmetric(
      //                   horizontal: 0, vertical: 10)),
      //         )),
      //   ],
      // ),
    );
  }

  Widget _renderPhone() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          'Phone number: ' + widget.user.phone!,
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.w800, fontSize: 18),
        ),
      ),

      // child: Column(
      //   children: [
      //     Padding(
      //         padding: const EdgeInsets.symmetric(
      //           horizontal: 40,
      //           vertical: 0,
      //         ),
      //         child: TextField(
      //           readOnly: true,
      //           // autofocus: true,
      //           // controller: controllerUsername,
      //           onChanged: (value) {},
      //           style: const TextStyle(
      //               color: Colors.black,
      //               fontWeight: FontWeight.w800,
      //               fontSize: 16),
      //           decoration: InputDecoration(
      //               hintText: 'Phone number: ' + widget.user.phone!,
      //               contentPadding: const EdgeInsets.symmetric(
      //                   horizontal: 0, vertical: 10)),
      //         )),
      //   ],
      // ),
    );
  }

  Widget _renderUsername() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          'Usernaem: ' + widget.user.name!,
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.w800, fontSize: 18),
        ),
      ),
      // child: Column(
      //   children: [
      //     Padding(
      //         padding: const EdgeInsets.symmetric(
      //           horizontal: 40,
      //           vertical: 0,
      //         ),
      //         child: TextField(
      //           readOnly: true,
      //           // autofocus: true,
      //           // controller: controllerUsername,
      //           onChanged: (value) {},
      //           style: const TextStyle(
      //               color: Colors.black,
      //               fontWeight: FontWeight.w800,
      //               fontSize: 16),
      //           decoration: InputDecoration(
      //               hintText: 'Usernaem: ' + widget.user.name!,
      //               contentPadding: const EdgeInsets.symmetric(
      //                   horizontal: 0, vertical: 10)),
      //         )),
      //   ],
      // ),
    );
  }

  Widget _renderPassword() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          'Password: ' + widget.user.password!,
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.w800, fontSize: 18),
        ),
      ),
      // child: Column(
      //   children: [
      //     Padding(
      //         padding: const EdgeInsets.symmetric(
      //           horizontal: 40,
      //           vertical: 0,
      //         ),
      //         child: TextField(
      //           readOnly: true,
      //           // autofocus: true,
      //           // controller: controllerUsername,
      //           onChanged: (value) {},
      //           style: const TextStyle(
      //               color: Colors.black,
      //               fontWeight: FontWeight.w800,
      //               fontSize: 16),
      //           decoration: InputDecoration(
      //               hintText: 'Password: ' + widget.user.password!,
      //               contentPadding: const EdgeInsets.symmetric(
      //                   horizontal: 0, vertical: 10)),
      //         )),
      //   ],
      // ),
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
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 30,
        ),
        child: Container(
          height: 50,
          width: 120,
          decoration: BoxDecoration(
              color: Colors.orange, borderRadius: BorderRadius.circular(20)),
          child: SizedBox(
            height: 90,
            width: 90,
            child: TextButton(
              onPressed: () => _bloc.add(GoEditeEvent()),
              child: const Text('EDITE', style: TextStyle(color: Colors.black)),
            ),
          ),
        ),
      ),
    );
  }

  Widget _renderDeleteButton() {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 10,
        ),
        child: Container(
          height: 50,
          width: 120,
          decoration: BoxDecoration(
              color: Colors.red, borderRadius: BorderRadius.circular(20)),
          child: SizedBox(
            height: 90,
            width: 90,
            child: TextButton(
              onPressed: () {},
              child: const Text(
                'DELETE',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ),
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
  }
}
