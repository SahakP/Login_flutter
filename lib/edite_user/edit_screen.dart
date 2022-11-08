import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:localization/localization.dart';

import 'package:snap_chat_copy/first_page/first_page_screen.dart';
import 'package:snap_chat_copy/repositiry/user_repo.dart';
import 'package:snap_chat_copy/repositiry/validation_repository.dart';

import '../model/user_model.dart';
import '../repositiry/api_repo.dart';
import '../widgets/un_focused.dart';
import 'bloc/edit_bloc.dart';

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
  late EditBloc _bloc;
  bool isLastNameValid = false;

  @override
  void initState() {
    _bloc = EditBloc(
        apiRepo: apiRepo, userRepo: userRepo, validationRepo: validationRepo);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => _bloc,
        child: BlocListener<EditBloc, EditState>(
          listener: _listener,
          child: BlocBuilder<EditBloc, EditState>(
            builder: _render,
          ),
        ));
  }

  Widget _render(BuildContext context, EditState state) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: UnFocusedWidget(
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.only(top: 100),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            _renderLastName(),
            _renderLastNameErrorMsg(),
            _renderFirstName(),
            _renderBDate(),
            _renderName(),
            _renderPhone(),
            _renderPassword(),
            _renderEmail()
          ]),
        )),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _renderSaveButton(),
            _renderDeleteButton(),
          ],
        ),
      ),
    );
  }

  Widget _renderLastName() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
      child: Column(
        children: [
          TextField(
            // autofocus: true,
            controller: lastNameController,
            onChanged: (value) {
              _bloc.add(LastNameEvent(lastName: value));
            },
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w800, fontSize: 16),
            decoration: InputDecoration(
                labelText: 'Last name: ', hintText: '${widget.user.lastName}'),
          )
        ],
      ),
    );
  }

  Widget _renderLastNameErrorMsg() {
    return !isLastNameValid
        ? Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
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
          ])
        : const Text('');
  }

  Widget _renderBDate() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
      child: Column(
        children: [
          TextField(
            // autofocus: true,
            // controller: birthdayController,
            // onChanged: (value) {},
            onTap: () {
              showCupertinoModalPopup(
                  // barrierColor: Colors.white,
                  context: context,
                  builder: (_) => _renderDataPicker());
            },
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w800, fontSize: 18),
            decoration: InputDecoration(
              labelText: 'Birth date: ',
              hintText:
                  DateFormat('dd MMMM yyyy').format(widget.user.birthday!),

              // hintText: '${widget.user.birthday.toString()}'
            ),
          )
        ],
      ),
    );
  }

  Widget _renderDataPicker() {
    return Container(
      height: 250,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 40,
          right: 40,
          bottom: 10,
          top: 10,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              height: 150,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                onDateTimeChanged: (value) {
                  // widget.user.birthday = value;
                  _bloc.add(BirthdayEvent(birthday: value.toString()));
                },
                initialDateTime: DateTime(now.year - 16, now.month, now.day),
              ),
            ),
            TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK')),
          ],
        ),
      ),
    );
  }

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

  Widget _renderPassword() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
      child: Column(
        children: [
          TextField(
            // autofocus: true,
            controller: passwordController,
            onChanged: (value) {},
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w800, fontSize: 18),
            decoration: InputDecoration(
                labelText: 'Password', hintText: '${widget.user.password}'),
          ),
        ],
      ),
    );
  }

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
            onPressed: () => _bloc.add(EditUserEvent(
                  lastName: lastNameController.text,
                  firstName: firstNameController.text,
                  name: naemController.text,
                  email: emailController.text,
                  phone: phoneController.text,
                  user: widget.user,
                  password: passwordController.text,
                  birthday: birthdayController.text,
                  // DateTime.parse(birthdayController.text),
                ))));
  }

  Widget _renderDeleteButton() {
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
        onPressed: () {
          _bloc.add(CancelEvent());
        },
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
    if (state is BirthdayState) {
      widget.user.birthday = DateTime.parse(state.birthday!);
    }
    if (state is CancelState) {
      Navigator.of(context).pop();
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => const HomePage()));
      // // Fluttertoast.showToast(msg: 'User deleted', gravity: ToastGravity.CENTER);
      // print('****************\n************\n');
    }
    if (state is LastNameState) {
      isLastNameValid = state.lastNameValid;
    }
  }
}
