import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization/localization.dart';
import 'package:snap_chat_copy/first_page/first_page_screen.dart';
import 'package:snap_chat_copy/repositiry/user_repo.dart';
import 'package:snap_chat_copy/repositiry/validation_repository.dart';
import 'package:snap_chat_copy/widgets/header.dart';

import '../model/user_model.dart';
import '../repositiry/api_repo.dart';
import '../widgets/back_button.dart';
import '../widgets/home.dart';
import '../widgets/un_focused.dart';
import 'bloc/edite_bloc.dart';

// ignore: must_be_immutable
class EditePage extends StatefulWidget {
  EditePage({required this.user, super.key});
  User user;

  @override
  State<EditePage> createState() => _EditePageState();
}

class _EditePageState extends State<EditePage> {
  final apiRepo = ApiRepo();
  final userRepo = UserRepo();
  final validationRepo = ValidationRepo();

  TextEditingController passwordController = TextEditingController();
  TextEditingController naemController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();
  late EditeBloc _bloc;

  @override
  void initState() {
    _bloc = EditeBloc(
        apiRepo: apiRepo, userRepo: userRepo, validationRepo: validationRepo);
    super.initState();
  }

  String get _validFormatDate {
    final formatter = DateFormat('dd MMMM yyyy');
    final birthday = formatter.format(widget.user.birthday!);
    return birthday;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => _bloc,
        child: BlocListener<EditeBloc, EditeState>(
          listener: _listener,
          child: BlocBuilder<EditeBloc, EditeState>(
            builder: _render,
          ),
        ));
  }

  Widget _render(BuildContext context, EditeState state) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: UnFocusedWidget(
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.only(top: 100),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            _renderLastName(),
            _renderFirstName(),
            _renderName(),
            _renderPhone(),
            // _renderPassword(),
            _renderEmail(),
            //_renderBDate()
          ]),
        )),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _renderSaveButton(),
            _renderCancelButton(),
          ],
        ),
      ),
    );
    //code

//  resizeToAvoidBottomInset: true,
//         backgroundColor: Colors.white,
//         body: Stack(children: [
//           const BackBtn(blueWhite: true),
//           Padding(
//             padding: const EdgeInsets.only(top: 100),
//             child: SingleChildScrollView(
//                 child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                   _renderLastName(),
//                   _renderFirstName(),
//                   _renderUsername(),
//                   _renderPhone(),
//                   _renderPassword(),
//                   _renderEmail(),
//                   _renderBDate()
//                 ])),
//           ),
    //             const Expanded(
    //               child: SizedBox(),
    //             ),
    //             Row(children: [
    //               _renderSaveButton(),
    //               const Expanded(child: SizedBox()),
    //               _renderCAncelButton(),
    //             ])
    //           ]),
    //     ),
    //   )
    // ]));
  }

  Widget _renderLastName() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
      child: Column(
        children: [
          TextField(
            // autofocus: true,
            controller: lastNameController,

            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w800, fontSize: 16),
            decoration: InputDecoration(
                labelText: 'Last name: ', hintText: '${widget.user.lastName}'),
          )
        ],
      ),
    );
  }

  // Widget _renderBDate() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
  //     child: Column(
  //       children: [
  //         TextField(
  //           // autofocus: true,
  //           controller: birthdayController,
  //           onChanged: (value) {},
  //           style: const TextStyle(
  //               color: Colors.black, fontWeight: FontWeight.w800, fontSize: 18),
  //           decoration: const InputDecoration(
  //               hintText: 'Birth date: ',
  //               contentPadding:
  //                   EdgeInsets.symmetric(horizontal: 0, vertical: 10)),
  //         )
  //       ],
  //     ),
  //   );
  // }

  Widget _renderFirstName() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
      child: Column(
        children: [
          TextField(
            // autofocus: true,
            controller: firstNameController,
            onChanged: (value) {},
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w800, fontSize: 16),
            decoration: InputDecoration(
              labelText: 'First name',
              hintText: '${widget.user.firstName}',
            ),
          )
        ],
      ),
    );
  }

  Widget _renderEmail() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
      child: Column(
        children: [
          TextField(
            // autofocus: true,
            controller: emailController,
            onChanged: (value) {},
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w800, fontSize: 16),
            decoration: InputDecoration(
                labelText: 'Email', hintText: '${widget.user.email}'),
          )
        ],
      ),
    );
  }

  Widget _renderPhone() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
      child: Column(
        children: [
          TextField(
            // autofocus: true,
            controller: phoneController,
            onChanged: (value) {},
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w800, fontSize: 16),
            decoration: InputDecoration(
                labelText: 'Phone number', hintText: '${widget.user.phone}'),
          ),
        ],
      ),
    );
  }

  Widget _renderName() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
      child: Column(
        children: [
          TextField(
            // autofocus: true,
            controller: naemController,
            onChanged: (value) {},
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w800, fontSize: 16),
            decoration: InputDecoration(
                labelText: 'Name', hintText: '${widget.user.name}'),
          ),
        ],
      ),
    );
  }

  // Widget _renderPassword() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
  //     child: Column(
  //       children: [
  //         TextField(
  //           // autofocus: true,
  //           controller: passwordController,
  //           onChanged: (value) {},
  //           style: const TextStyle(
  //               color: Colors.black, fontWeight: FontWeight.w800, fontSize: 18),
  //           decoration: const InputDecoration(
  //               labelText: 'Password: ',
  //               contentPadding:
  //                   EdgeInsets.symmetric(horizontal: 0, vertical: 10)),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _renderSaveButton() {
    return ConstrainedBox(
        constraints: const BoxConstraints.tightFor(width: 120, height: 50),
        child: ElevatedButton(
            child: const Text(
              'Save',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15.0,
              ),
            ),
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 36, 174, 252)),
            onPressed: () => _bloc.add(LastNameEvent(
                lastName: lastNameController.text,
                firstName: firstNameController.text,
                name: naemController.text,
                email: emailController.text,
                phone: phoneController.text,
                user: widget.user,
                password: passwordController.text))));
  }

  Widget _renderCancelButton() {
    return ConstrainedBox(
      constraints: const BoxConstraints.tightFor(width: 120, height: 50),
      child: ElevatedButton(
        child: const Text(
          'Cancel',
          style: TextStyle(
            color: Colors.white,
            fontSize: 15.0,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 185, 193, 199),
        ),
        onPressed: () {},
      ),
    );
  }
}

extension _BlocListener on _EditePageState {
  void _listener(context, state) {
    if (state is EditUserState) {
      widget.user = state.user!;
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => FirstPage(
                    user: widget.user,
                  )));
    }
  }
}
