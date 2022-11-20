import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:localization/localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:path/path.dart';
import 'package:snap_chat_copy/repositiry/validation/validation_repository.dart';

import '../../model/user_model.dart';
import '../../repositiry/mongoDb/user_mongo_repo.dart';
import '../../services/Api/api_service.dart';
import '../../utill/exepshon_map.dart';
import '../../utill/header.dart';
import '../../utill/un_focused.dart';
import '../first_page/first_page_screen.dart';
import 'bloc/edit_bloc.dart';

// ignore: must_be_immutable
class EditePage extends StatefulWidget {
  EditePage({required this.user, super.key});
  User user;

  @override
  State<EditePage> createState() => _EditePageState();
}

class _EditePageState extends State<EditePage> {
  final apiRepo = ApiService();
  final userRepo = UserMongoRepo();
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
  bool isBirthdayValid = true;
  var _birthday;
  bool isFirstNameValid = false;
  bool isNameValid = false;
  bool isNameChecked = false;

  bool isPhoneValid = false;
  bool isPassValid = false;
  bool isEmailVAlid = false;
  var expMsg = ExpMap().expMsg;
  String nameExpMsge = 'NameErrorMsg'.i18n();
  String phoneExpMsg = 'usernaemErrorMsg'.i18n();
  String emailExpMsg = 'emailErrorMsg'.i18n();
  //var expMsg = ExpMap().expMsg;
  // String? expMsg;

  @override
  void initState() {
    _bloc = EditBloc(
        apiService: apiRepo,
        userMongoRepo: userRepo,
        validationRepo: validationRepo);
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
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Header(header: 'EditHeder'.i18n()),
          _renderLastName(),
          _renderLastNameErrorMsg(),
          _renderFirstName(),
          _renderFirstNameErrorMsg(),
          _renderBDate(),
          _renderBDateErrorMsg(),
          _renderName(),
          _renderNameErrorMsg(),
          _renderPhone(),
          _renderPhoneErrorMsg(),
          _renderPassword(),
          _renderPasswordErrorMsg(),
          _renderEmail(),
          _renderEmailErrorMsg()
        ]),
      )),
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
  }

  Widget _renderLastName() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
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
                labelText: 'Last name: ${widget.user.lastName} '),
          )
        ],
      ),
    );
  }

  Widget _renderLastNameErrorMsg() {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 40,
          ),
          child: Text(
            !isLastNameValid ? 'usernaemErrorMsg'.i18n() : '',
            style: const TextStyle(
                color: Color.fromARGB(255, 185, 193, 199),
                fontWeight: FontWeight.w700,
                fontSize: 12),
          ))
    ]);
  }

  Widget _renderBDate() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
      child: Column(
        children: [
          TextField(
            controller: birthdayController,
            onChanged: (value) {},
            onTap: () {
              showCupertinoModalPopup(
                  context: context, builder: (_) => _renderDataPicker());
            },
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w800, fontSize: 18),
            decoration: InputDecoration(
              labelText:
                  'Birth date: ${DateFormat('dd MMMM yyyy').format(widget.user.birthday!)}',

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
                  _bloc.add(BirthdayEvent(
                    birthday: value.toString(),
                  ));
                },
                initialDateTime: DateTime(now.year - 16, now.month, now.day),
              ),
            ),
            TextButton(
                onPressed: () {
                  if (isBirthdayValid) {
                    widget.user.birthday = _birthday;
                    Navigator.of(context).pop();
                  } else {
                    widget.user.birthday =
                        DateTime(now.year - 16, now.month, now.day);
                  }
                },
                child: const Text('OK')),
          ],
        ),
      ),
    );
  }

  Widget _renderBDateErrorMsg() {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 40,
          ),
          child: Text(
            !isBirthdayValid ? 'birthdayErrorMsg'.i18n() : '',
            style: const TextStyle(
                color: Colors.red, fontWeight: FontWeight.w700, fontSize: 12),
          ))
    ]);
  }

  Widget _renderFirstName() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: Column(
        children: [
          TextField(
            controller: firstNameController,
            onChanged: (value) {
              _bloc.add(FirstNameEvent(firstName: firstNameController.text));
            },
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w800, fontSize: 16),
            decoration: InputDecoration(
              labelText: 'First name: ${widget.user.firstName}',
            ),
          )
        ],
      ),
    );
  }

  Widget _renderFirstNameErrorMsg() {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 40,
          ),
          child: Text(
            !isFirstNameValid ? 'usernaemErrorMsg'.i18n() : '',
            style: const TextStyle(
                color: Color.fromARGB(255, 185, 193, 199),
                fontWeight: FontWeight.w700,
                fontSize: 12),
          ))
    ]);
  }

  Widget _renderEmail() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: Column(
        children: [
          TextField(
            controller: emailController,
            onChanged: (value) {
              _bloc.add(EmailEvent(email: emailController.text));
            },
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w800, fontSize: 16),
            decoration:
                InputDecoration(labelText: 'Email: ${widget.user.email} '),
          )
        ],
      ),
    );
  }

  Widget _renderEmailErrorMsg() {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 40,
          ),
          child: Text(
            !isEmailVAlid ? 'emailErrorMsg'.i18n() : '',
            style: const TextStyle(
                color: Color.fromARGB(255, 185, 193, 199),
                fontWeight: FontWeight.w700,
                fontSize: 12),
          ))
    ]);
  }

  Widget _renderPhone() {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      Expanded(
          child: Align(
              alignment: FractionalOffset.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 35),
                child: _countryList(),
              ))),
      Expanded(
          child: Align(
              alignment: FractionalOffset.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(right: 0),
                child: _renderPhoneNumberTF(),
              ))),
      const Expanded(
          child: Align(
        alignment: FractionalOffset.centerRight,
        child: Text(''),
      ))
    ]);
  }

  Widget _countryList() {
    return TextButton(
      style: TextButton.styleFrom(
        textStyle: const TextStyle(fontSize: 16),
      ),
      onPressed: () {
        //   Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //           builder: (context) => ChangeNotifierProvider.value(
        //               value: changeNotif,
        //               child: CountryList(
        //                 //valueNotif: changeNotif,
        //                 countriesList: _countries,
        //                 // country: (Country country) {
        //                 //   setState(() {
        //                 //     _selectedCountry = country;
        //                 //   });
        //                 // },
        //               ))));
      },
      child: Text('flagMaker()'),
    );
  }

  //TODO: country list stanal mongoyov

  // String flagMaker() {
  //   final country =' _selectedCountry';
  //   if (country == null) {
  //     return '';
  //   }

  //   final flag = country.countryName.toUpperCase().replaceAllMapped(
  //       RegExp(r'[A-Z]'),
  //       (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397));

  //   return flag + ' +' + country.countryPhoneCode;
  // }

  Widget _renderPhoneNumberTF() {
    return TextField(
      decoration: const InputDecoration(
        border: InputBorder.none,
      ),
      autofocus: true,
      keyboardType: TextInputType.number,
      controller: phoneController,
      onChanged: (value) {
        _bloc.add(PhoneEvent(phone: phoneController.text));
      },
      style: const TextStyle(
          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
    );
  }

  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
  //     child: Column(
  //       children: [
  //         TextField(
  //           controller: phoneController,
  //           onChanged: (value) {
  //             _bloc.add(PhoneEvent(phone: phoneController.text));
  //           },
  //           style: const TextStyle(
  //               color: Colors.black, fontWeight: FontWeight.w800, fontSize: 16),
  //           decoration: InputDecoration(
  //               labelText: 'Phone number: ${widget.user.phone}'),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _renderPhoneErrorMsg() {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 40,
          ),
          child: Text(
            phoneExpMsg,
            style: const TextStyle(
                color: Color.fromARGB(255, 185, 193, 199),
                fontWeight: FontWeight.w700,
                fontSize: 12),
          ))
    ]);
  }

  Widget _renderName() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: Column(
        children: [
          TextField(
            controller: naemController,
            onChanged: (value) {
              _bloc.add(NameEvent(name: naemController.text));
            },
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w800, fontSize: 16),
            decoration: InputDecoration(labelText: 'Name: ${widget.user.name}'),
          ),
        ],
      ),
    );
  }

  Widget _renderNameErrorMsg() {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 40,
          ),
          child: Text(
            nameExpMsge,
            style: const TextStyle(
                color: Color.fromARGB(255, 185, 193, 199),
                fontWeight: FontWeight.w700,
                fontSize: 12),
          ))
    ]);
  }

  Widget _renderPassword() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: Column(
        children: [
          TextField(
            controller: passwordController,
            onChanged: (value) {
              _bloc.add(PasswordEvent(password: passwordController.text));
            },
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w800, fontSize: 18),
            decoration:
                InputDecoration(labelText: 'Password: ${widget.user.password}'),
          ),
        ],
      ),
    );
  }

  Widget _renderPasswordErrorMsg() {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 40,
          ),
          child: Text(
            !isPassValid ? 'passwordErrorMsg'.i18n() : '',
            style: const TextStyle(
                color: Color.fromARGB(255, 185, 193, 199),
                fontWeight: FontWeight.w700,
                fontSize: 12),
          ))
    ]);
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
                ))));
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
      _birthday = DateTime.parse(state.birthday!);
      isBirthdayValid = state.birthValid;
    }
    if (state is CancelState) {
      Navigator.of(context).pop();
    }
    if (state is LastNameState) {
      isLastNameValid = state.lastNameValid;
    }
    if (state is FirstNameState) {
      isFirstNameValid = state.isFirstNameValid;
    }
    if (state is NameValidationState) {
      nameExpMsge = state.nameExpMsg;
    }
    if (state is NameState) {
      nameExpMsge = state.nameExpMsg;
    }
    if (state is NameCheckState) {
      nameExpMsge = state.nameExpMsg;
    }
    if (state is PhoneState) {
      phoneExpMsg = state.phoneExpMsg;
    }
    if (state is PhoneValidationState) {
      phoneExpMsg = state.phoneExpMsg;
    }
    if (state is PhoneCheckState) {
      phoneExpMsg = state.phoneExpMsg;
    }
    if (state is PasswordState) {
      isPassValid = state.isPassValid;
    }
    if (state is EmailState) {
      emailExpMsg = state.emailExpMsg;
    }
    if (state is EmailValidationState) {
      emailExpMsg = state.emailExpMsg;
    }
    if (state is EmailCheckState) {
      emailExpMsg = state.emailExpMsg;
    }
  }
}
