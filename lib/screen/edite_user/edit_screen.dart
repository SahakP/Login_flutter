import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:localization/localization.dart';
import 'package:provider/provider.dart';
import 'package:snap_chat_copy/repositiry/mongoDb/country_mongo_repo.dart';

import 'package:snap_chat_copy/repositiry/validation/validation_repository.dart';

import '../../model/country_model.dart';
import '../../model/user_model.dart';
import '../../notifier/change_notifier.dart';
import '../../repositiry/mongoDb/user_mongo_repo.dart';
import '../../repositiry/Api/api_repo.dart';
import '../../utill/country_list.dart';
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
  TextEditingController passwordController = TextEditingController();
  TextEditingController naemController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();

  var apiService = ApiRepo();
  final userRepo = UserMongoRepo();
  final validationRepo = ValidationRepo();
  final countryRepo = CountryMongoRepo();

  bool isFirstNameValid = false;
  bool isLastNameValid = false;
  bool isBirthdayValid = true;
  bool isNameValid = false;
  bool isPhoneValid = false;
  bool isEmailValid = false;
  bool isPassValid = false;
  //TODO: make it fals logic
  bool isLoading = true;

  var expMsg = ExpMap().expMsg;
  var _birthday;
  String nameExpMsge = 'NameErrorMsg'.i18n();
  String phoneExpMsg = 'usernaemErrorMsg'.i18n();
  String emailExpMsg = 'emailErrorMsg'.i18n();

  MyChangeNotifier get changeNotif =>
      Provider.of<MyChangeNotifier>(context, listen: false);

  Country? _selectedCountry;

  List<Country> _countries = [];

  final _bloc = EditBloc(
      countryMongoRepo: CountryMongoRepo(),
      apiRepo: ApiRepo(),
      userMongoRepo: UserMongoRepo(),
      validRepo: ValidationRepo());

  @override
  void initState() {
    changeNotif.addListener(_onChange);
    _bloc.add(CountriesEvent());
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

  Widget _renderFirstName() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
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
                color: Colors.black, fontWeight: FontWeight.w800, fontSize: 16),
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

  Widget _renderName() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
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

  Widget _renderPhone() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
        child: Column(children: [
          TextField(
            keyboardType: TextInputType.number,
            controller: phoneController,
            onChanged: (value) {
              _bloc.add(PhoneEvent(phone: phoneController.text));
            },
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w800, fontSize: 16),
            decoration: InputDecoration(
                prefix: _countryList(),
                labelText: 'Phone: +${widget.user.phone}'),
          )
        ]));
  }

  Widget _countryList() {
    return TextButton(
      style: TextButton.styleFrom(
        textStyle: const TextStyle(fontSize: 16),
      ),
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChangeNotifierProvider.value(
                    value: changeNotif,
                    child: CountryList(
                      countriesList: _countries,
                    ))));
      },
      child: isLoading ? const CupertinoActivityIndicator() : Text(flagMaker()),
    );
  }

  String flagMaker() {
    final country = _selectedCountry;

    if (country == null) {
      return '';
    }

    final flag = country.countryName.toUpperCase().replaceAllMapped(
        RegExp(r'[A-Z]'),
        (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397));

    return flag + ' +' + country.countryPhoneCode;
  }

  void _onChange() {
    _selectedCountry = changeNotif.country;
    setState(() {});
  }

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
            !isEmailValid ? 'emailErrorMsg'.i18n() : '',
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
            onPressed: () => _bloc.add(SaveUserEvent(
                  lastName: lastNameController.text,
                  firstName: firstNameController.text,
                  name: naemController.text,
                  email: emailController.text,
                  phone: _selectedCountry!.countryPhoneCode +
                      ' ' +
                      phoneController.text,
                  password: passwordController.text,
                  birthday: birthdayController.text,
                  user: widget.user,
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
    if (state is SaveUserState) {
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

    if (state is NameSuccessState) {
      nameExpMsge = state.nameExpMsg;
      isNameValid = state.isNameValid;
    }
    if (state is NameCheckState) {
      nameExpMsge = state.nameExpMsg;
      isNameValid = state.isNameValid;
    }

    if (state is PhoneSuccessState) {
      phoneExpMsg = state.phoneExpMsg;
      isPhoneValid = state.isPhoneValid;
    }

    if (state is PhoneCheckState) {
      phoneExpMsg = state.phoneExpMsg;
      isPhoneValid = state.isPhoneValid;
    }

    if (state is EmailSuccessState) {
      emailExpMsg = state.emailExpMsg;
      isEmailValid = state.isEmailValid;
    }

    if (state is EmailCheckState) {
      emailExpMsg = state.emailExpMsg;
      isEmailValid = state.isEmailValid;
    }

    if (state is PasswordState) {
      isPassValid = state.isPassValid;
    }

    if (state is CountriesState) {
      _countries = state.countries;
      _selectedCountry = state.currentLocation;
      isLoading = false;
    }
    if (state is LoadinState) {}
  }
}
